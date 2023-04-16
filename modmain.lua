--????????????????338?????????????
--?????????187-189?, ??????1?????????
--????????????????pick?????????pick??????sg??????????????????????

TUNING.SCYTHE_USES = 50
TUNING.GOLDENSCYTHE_USES = 200
TUNING.SCYTHE_DAMAGE = 34

local mow_durability = GetModConfigData("durability")
if mow_durability == "normal" then
		TUNING.SCYTHE_USES = 25
		TUNING.GOLDENSCYTHE_USES = 100
	elseif mow_durability == "good" then
		TUNING.SCYTHE_USES = 40
		TUNING.GOLDENSCYTHE_USES = 160
	elseif mow_durability == "fine" then
		TUNING.SCYTHE_USES = 50
		TUNING.GOLDENSCYTHE_USES = 200
	elseif mow_durability == "excellent" then
		TUNING.SCYTHE_USES = 75
		TUNING.GOLDENSCYTHE_USES = 300
	elseif mow_durability == "durable" then
		TUNING.SCYTHE_USES = 125
		TUNING.GOLDENSCYTHE_USES = 500
	else
end




PrefabFiles = {
    "scythe",
    "scythe_golden",
}

Assets = 
{
	Asset("ATLAS", "images/inventoryimages/scythe.xml"),
	Asset("ATLAS", "images/inventoryimages/scythe_golden.xml"),

	Asset( "IMAGE", "images/inventoryimages/scythe.tex" ),
	Asset( "IMAGE", "images/inventoryimages/scythe_golden.tex" ),

	Asset("ANIM", "anim/scythe.zip"),
	Asset("ANIM", "anim/scythe_golden.zip"),


	Asset("ANIM", "anim/swap_scythe.zip"),
	Asset("ANIM", "anim/swap_scythe_golden.zip"),


}

--GLOBAL =_G

local Ingredient = GLOBAL.Ingredient
local RECIPETABS = GLOBAL.RECIPETABS
local STRINGS = GLOBAL.STRINGS
local TECH = GLOBAL.TECH

GLOBAL.STRINGS.NAMES.SCYTHE = "Scythe"
GLOBAL.STRINGS.RECIPE_DESC.SCYTHE = "Mow down packs of enemies."
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.SCYTHE = "Mow down packs of enemies."

              
GLOBAL.STRINGS.NAMES.SCYTHE_GOLDEN = "Golden Scythe"        --剽殷鎺菛灆
GLOBAL.STRINGS.RECIPE_DESC.SCYTHE_GOLDEN = "Gathering more effective."
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.SCYTHE_GOLDEN = "Gathering more effective."
GLOBAL.STRINGS.ACTIONS.MOWDOWN = "Mow Down" --Appears in the game.

--- translate modmain
modimport("modlangstrings")


--local scythe = GLOBAL.Recipe("scythe", { Ingredient("twigs", 2), Ingredient("rope", 1), Ingredient("flint", 2)}, RECIPETABS.TOOLS, {SCIENCE = 1} )
local scythe = AddRecipe2("scythe", { Ingredient("twigs", 2), Ingredient("rope", 1), Ingredient("flint", 2)}, TECH.SCIENCE_ONE, nil, {"TOOLS"})
scythe.atlas = "images/inventoryimages/scythe.xml"

local scythe_golden = AddRecipe2("scythe_golden", { Ingredient("twigs", 4), Ingredient("rope", 2), Ingredient("goldnugget", 2)},{SCIENCE = 2},nil, {"TOOLS"})
scythe_golden.atlas = "images/inventoryimages/scythe_golden.xml"


-----------------------------------------------------------------------------------
--褗悝謭鼝湩
--1.叼骠义鲗鎺�禳逌� 徰糌纛烐湭徰糌◥汊义鲗鎺舢做湭�菌徱鬻岕畀饻�纛�皤犚洔�义鲗讒掹

-------------------------------------------
-- I based this code off of a similar piece written by TheDanaAddams
-- creator of the popular link don't starve character
-- the URL of that Modder is : http://forums.kleientertainment.com/user/267484-thedanaaddams/?tab=idm

-- the "Mow" action, needs to be created to allow "Mow" action in game
local STRINGS = GLOBAL.STRINGS
local RECIPETABS = GLOBAL.RECIPETABS
local Recipe = GLOBAL.Recipe
local GIngredient = GLOBAL.Ingredient
local TECH = GLOBAL.TECH

local require = GLOBAL.require
local FRAMES = GLOBAL.FRAMES
local ACTIONS = GLOBAL.ACTIONS
local State = GLOBAL.State
local EventHandler = GLOBAL.EventHandler
local ActionHandler = GLOBAL.ActionHandler
local TimeEvent = GLOBAL.TimeEvent
local EQUIPSLOTS = GLOBAL.EQUIPSLOTS

local cooldowntime = 9
local starttime = 3
local endtime = 12
--as default 

local picking_rate = GetModConfigData("picking_rate")
------------------------------------------------------??????

if (picking_rate == "crazy") then
	
	cooldowntime = 1
	starttime = 0
	endtime = 1
	
elseif (picking_rate == "veryfast") then
	
	cooldowntime = 3
	starttime = 2
	endtime = 6
	
elseif (picking_rate == "fast") then
	
	cooldowntime = 6
	starttime = 3
	endtime = 9
	
elseif (picking_rate == "normal") then
	
	cooldowntime = 8
	starttime = 3
	endtime = 12
	
elseif (picking_rate == "slow") then
	
	cooldowntime = 11
	starttime = 4
	endtime = 15
	
end


MOWDOWN = GLOBAL.Action(1)
MOWDOWN.id = "MOWDOWN"                                               
MOWDOWN.str = GLOBAL.STRINGS.ACTIONS.MOWDOWN
MOWDOWN.fn = function(act)

--[[
local test 
if act and act.doer and act.doer.components and act.doer.components.inventory then 
	test =  act.doer.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS):HasTag("mower")
end

if test then
	print "pass"
	else print "no pass"
	end
]]

    if act.target.components.pickable  then
        act.target.components.pickable:Pick(act.doer)
        return true
    end
end
 ---------------------------------------test



AddAction(MOWDOWN)        --?????-dst published ?????preview?? bugreport1 ????? 
--???????componentactions.lua  components\playactionpicker.lua ?? components\playcontroller.lua




local mowAtDown= State({
    name = "mowdown",
    tags = { "doing", "busy" },

    onenter = function(inst)
		local equip = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)		--

		--inst.sg.statemem.action = inst:GetBufferedAction()
		--ismower = inst:HasTag("mower")    --test
		inst.components.locomotor:Stop()

		 
		local cooldown = cooldowntime*FRAMES
						
		if equip and equip:HasTag("mower")  then
--			print("??")
			inst.AnimState:PlayAnimation("atk")								--????????????????
			inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_weapon")
		end

		inst.sg:SetTimeout(cooldown)  --
    end,



    timeline =
    {		
	GLOBAL.TimeEvent(starttime*GLOBAL.FRAMES, function( inst ) --???              ---can find in  stategraph.lua -------jia l
		inst.sg:RemoveStateTag("busy")
		end),

		GLOBAL.TimeEvent(cooldowntime*GLOBAL.FRAMES, function( inst ) --Go to next object
             local equip = inst.components.inventory and inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS) or nil
		     inst:PerformBufferedAction() 

             if equip and equip:HasTag("mower") and equip.components.finiteuses then  --?????????????
                   --equip.mowtask = equip:DoTaskInTime(0, function(inst)  
                        equip.components.finiteuses:Use(1)  
                        --[[    	    
                         ?????1???1?????????????????????????????
                         1. TUNING.SCYTHE_USE ? TUNING.GOLDENSCYTHE_USES ?????????????????
                         2. ??modmain()?  equip.components.finiteuses:Use(0.4)  ???????
                         3. ???prefabs???????? inst.components.finiteuses:SetConsumption(ACTIONS.MOWDOWN, 0.4)
							?????????
                         ]]
                         --equip.mowtask = Cancel()
                         --equip.mowtask = nil
                   --end)   
             end 		      
		end),

	GLOBAL.TimeEvent(endtime*GLOBAL.FRAMES, function( inst ) --Go to next object
		inst.sg:RemoveStateTag("doing")
		inst.sg:AddStateTag("idle")

		end),
	},

	ontimeout = function(inst)               --???????????????
	--inst:PerformBufferedAction()      
	end,
	
-------------------test end-------

    events =
    {
   		--  EventHandler("unequip", function(inst) inst.sg:GoToState("idle") end),  --test
  		  EventHandler("animover", function(inst)
  		   if inst.AnimState:AnimDone() then 
  		   	inst.sg:GoToState("idle") 
  		   	end
  		   end )
    },
	
-------------test
--[[
    onexit = 
    function(inst)
		if inst.bufferedaction == inst.sg.statemem.action then
            inst:ClearBufferedAction()
        end
        inst.sg.statemem.action = nil
    end,
 ----------------test end  
]]
})


-----------------------???????? SGwilson_client.lua  ?????????             
--ps???configure?? ?? cooldown?10? ? timeline?? 4?starttime? 14?endtime?????.  ??cooldown???????4??????14 ?????????
local mowAtDown_client= State({
    name = "mowdown",
    tags = { "doing", "busy" },

    onenter = function(inst)
		local equip = inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)		--

		--inst.sg.statemem.action = inst:GetBufferedAction()
		--ismower = inst:HasTag("mower")    --test
		inst.components.locomotor:Stop()

		local cooldown = cooldowntime * FRAMES	--client??cooldown ?????????????client??cooldown??????????????????client??????

		if  equip:HasTag("mower")  then
--			print("??")
			inst.AnimState:PlayAnimation("atk")								--????????????????
			inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_weapon")
			--inst.AnimState:PlayAnimation("mowdown")
		end

 inst:PerformPreviewBufferedAction()   ---------?client????? ???????????????????inst:PerformBufferedAction()
 --?????xxx_client ???????inst:PerformBufferedAction()?   inst:PerformPreviewBufferedAction()  ?????
		inst.sg:SetTimeout(cooldown)  --
    end,



    timeline =
    {		
	GLOBAL.TimeEvent(starttime* GLOBAL.FRAMES, function( inst ) --???              ---can find in  stategraph.lua -------jia l
		inst.sg:RemoveStateTag("busy")
		end),
			GLOBAL.TimeEvent(cooldowntime*GLOBAL.FRAMES, function( inst ) --Go to next object
		inst:PerformBufferedAction()  
		end),
	GLOBAL.TimeEvent(endtime * GLOBAL.FRAMES, function( inst ) --Go to next object
		inst.sg:RemoveStateTag("doing")
		inst.sg:AddStateTag("idle")
		end),
	},
	  
    events =
    {
   		-- EventHandler("unequip", function(inst) inst.sg:GoToState("idle") end),  --test
  		  EventHandler("animover", function(inst)
  		   if inst.AnimState:AnimDone() then 
  		   	inst.sg:GoToState("idle") 
  		   	end
  		   end )
    },

})







AddStategraphState("wilson", mowAtDown)

----?????Addaction?? ,?????action???????????
--[[
AddStategraphActionHandler("wilson", ActionHandler(ACTIONS.MOWDOWN, function(inst, action)
																					local tool = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
																					return (tool:HasTag("mower") and "mowdown")  
																				end
																		)
)
]]


AddStategraphState("wilson_client", mowAtDown_client)

--[[
AddStategraphActionHandler("wilson_client", ActionHandler(ACTIONS.MOWDOWN, function(inst, action)
																					local tool = inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)																
																					return (tool:HasTag("mower") and "mowdown")  
																			end
																		)
)
]]
-----------------------(??ACTIONS.MOWDOWN???????????ACTIONS.PICK,??scythe.lua?? consumption ?? ACTIONS.PICK)--------------

---------------------------------------------------------
--local SGWils = require "stategraphs/SGwilson"
--local SGWils_client = require "stategraphs/SGwilson_client"
--local OriginalDestStatePICK
--[[
for k, v in pairs(SGWils.actionhandlers) do
	if SGWils.actionhandlers[k]["action"]["id"] == "PICK" then	
		OriginalDestStatePICK = SGWils.actionhandlers[k]["deststate"]
	end
end
]]

local mow_farmplant = GetModConfigData("mow_farmplant")
local mow_berrybush = GetModConfigData("mow_berrybush")
local mow_rock_avocado_bush = GetModConfigData("mow_rock_avocado_bush")

local function NewPICK(inst, action)
	local tool 
	if inst and inst.components and inst.components.inventory then
		tool = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS) 
	else tool = nil
	end 

	if action.target.components.pickable ~= nil then
                                                                                                                                                                --??????????????"farm_plant"????
--		if tool and tool:HasTag("mower") and ((action.target.prefab == "grass") or (action.target.prefab == "sapling") or (action.target.prefab == "reeds") or (action.target:HasTag("farm_plant"))) then  --???????????????????pick??
--				return "mowdown"
		if tool and tool:HasTag("mower") and ((action.target.prefab == "grass") or (action.target.prefab == "sapling") or (action.target.prefab == "reeds") ) then  --???????????????????pick??
				return "mowdown"

			elseif (mow_farmplant == "yes") and tool and tool:HasTag("mower") and (action.target:HasTag("farm_plant")) then
					return "mowdown"

			elseif (mow_berrybush == "yes") and tool and tool:HasTag("mower")  and ((action.target.prefab == "berrybush2") or (action.target.prefab == "berrybush")) then
					return "mowdown"
			elseif (mow_rock_avocado_bush == "yes") and tool and tool:HasTag("mower") and  (action.target.prefab == "rock_avocado_bush") then
					return "mowdown"				
					
			elseif action.target.components.pickable.quickpick then
					return "doshortaction"
					
			elseif action.target.components.pickable.jostlepick then
					return "dojostleaction"
			else
					return "dolongaction"			
		end
	else 

	return nil
	end
end


local function NewPICK_client(inst, action)
	local tool 
	if inst and inst.replica and inst.replica.inventory then
		tool = inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
	else tool = nil
	end 
--[[
if  tool and tool:HasTag("mower")  and ((action.target.prefab == "grass") or (action.target.prefab == "sapling") or (action.target.prefab == "reeds"))  then
	print ( "1")
else
	print "no 1"
end
if action.target.prefab == "grass" then
	print ("2")
else
	print "no 2"
end
if  tool:HasTag("mower") then
	print "3"
else
	print "3"
end
]]
		if tool and tool:HasTag("mower")  and ((action.target.prefab == "grass") or (action.target.prefab == "sapling") or (action.target.prefab == "reeds")) then                               --???????????????????pick??
				return "mowdown"

			elseif (mow_farmplant == "yes") and tool and tool:HasTag("mower") and (action.target:HasTag("farm_plant")) then
					return "mowdown"

		--	elseif (mow_berrybush == "yes") and tool and tool:HasTag("mower")  and ((action.target.prefab == "berrybush2") or (action.target.prefab == "berrybush") or (action.target.prefab == "berrybush_juicy")) then
		--			return "mowdown"

			elseif (mow_berrybush == "yes") and tool and tool:HasTag("mower")  and ((action.target.prefab == "berrybush2") or (action.target.prefab == "berrybush")) then
					return "mowdown"
			elseif (mow_rock_avocado_bush == "yes") and tool and tool:HasTag("mower") and  (action.target.prefab == "rock_avocado_bush") then
					return "mowdown"			
		
			elseif action.target:HasTag("quickpick") then
				return "doshortaction"
				
			elseif action.target:HasTag("jostlepick") then
				return "dojostleaction"
				
			else
				return "dolongaction"
				
			end
	
end

AddStategraphActionHandler("wilson", ActionHandler(ACTIONS.PICK, NewPICK))             --??SGwilson? actionhandlers{}??ACTIONS.PICK ???? NewPICK
GLOBAL.package.loaded["stategraphs/SGwilson"] = nil 


AddStategraphActionHandler("wilson_client", ActionHandler(ACTIONS.PICK, NewPICK_client))
GLOBAL.package.loaded["stategraphs/SGwilson_client"] = nil 


--------test
--[[
local function addActionButtonPostInit(inst,self)
--------------------------------------------------------test1

-------------------------------------------------------------
	inst.standardGetAction = inst.GetActionButtonAction
	function inst:GetActionButtonAction()
		local bact = self:standardGetAction()
		if bact == nil then
			return
		end
		if bact.target.prefab ~= "grass" and bact.target.prefab ~= "reeds" and bact.target.prefab ~= "sapling" then
			return bact
		end
		if bact.doer and bact.target and
			bact.action == ACTIONS.PICK and bact.invobject and bact.invobject:HasTag("mower") then
			bact.action = ACTIONS.MOWDOWN
		end
		return bact
	end
end
 -------------------------test

AddComponentPostInit("playercontroller", addActionButtonPostInit)
]]