--自定义可以被镰刀砍伐的对象代码在338行，有个添加农场作物的范例
--镰刀扣除耐久相关在187-189行, 默认一次扣除1点耐久，可自行更改
--排队论相关的因为镰刀用的是官方的pick动作，这里只需要对pick所执行对应的sg修改下就好，如果要添加新动作的话需要另外兼容

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



local Ingredient = GLOBAL.Ingredient
local RECIPETABS = GLOBAL.RECIPETABS
local STRINGS = GLOBAL.STRINGS
local TECH = GLOBAL.TECH

GLOBAL.STRINGS.NAMES.SCYTHE = "Scythe"
GLOBAL.STRINGS.RECIPE_DESC.SCYTHE = "Mow down packs of enemies."
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.SCYTHE = "Mow down packs of enemies."

              
GLOBAL.STRINGS.NAMES.SCYTHE_GOLDEN = "Golden Scythe"        --ÏÔÊ¾µÄÃû×Ö
GLOBAL.STRINGS.RECIPE_DESC.SCYTHE_GOLDEN = "Gathering more effective."
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.SCYTHE_GOLDEN = "Gathering more effective."


local scythe = GLOBAL.Recipe("scythe", { Ingredient("twigs", 2), Ingredient("rope", 1), Ingredient("flint", 2)}, RECIPETABS.TOOLS, {SCIENCE = 1} )
scythe.atlas = "images/inventoryimages/scythe.xml"

local scythe_golden = GLOBAL.Recipe("scythe_golden", { Ingredient("twigs", 4), Ingredient("rope", 2), Ingredient("goldnugget", 2)}, RECIPETABS.TOOLS, {SCIENCE = 2} )
scythe_golden.atlas = "images/inventoryimages/scythe_golden.xml"


-----------------------------------------------------------------------------------
--ÐèÒªÍê³É£º
--1.Á­µ¶ÊÕ¸îµÄ¹ý³Ì£º ÅÐ¶Ï¶¯×÷£¬ÅÐ¶Ï¿ÉÒÔÊÕ¸îµÄ¶«Î÷£¬²¥·ÅÊÕ¸î¶¯»­£¬¶¯»­½áÊø£¬ÊÕ¸îÎïÆ·

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
------------------------------------------------------设置采集速率

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

GLOBAL.STRINGS.ACTIONS.MOWDOWN = "Mow Down" --Appears in the game.

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



AddAction(MOWDOWN)        --貌似会出现-dst published 文件夹下，preview里面 bugreport1 上面的问题 
--（可能会关系到componentactions.lua  components\playactionpicker.lua 以及 components\playcontroller.lua




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
--			print("执行")
			inst.AnimState:PlayAnimation("atk")								--因为尚未做动画，所以先用攻击动画
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

             if equip and equip:HasTag("mower") and equip.components.finiteuses then  --判断手持的为镰刀时才扣耐久
                   --equip.mowtask = equip:DoTaskInTime(0, function(inst)  
                        equip.components.finiteuses:Use(1)  
                        --[[    	    
                         默认为攻击1次消耗1的耐久，若要想攻击消耗的耐久与收割消耗的耐久不同，则需要：
                         1. TUNING.SCYTHE_USE 和 TUNING.GOLDENSCYTHE_USES 为基础次数，也是“攻击消耗次数”，
                         2. 把本modmain()的  equip.components.finiteuses:Use(0.4)  里面的数字调整
                         3. 对应的prefabs脚本里的数字调整 inst.components.finiteuses:SetConsumption(ACTIONS.MOWDOWN, 0.4)
							否则显示的数字不对
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

	ontimeout = function(inst)               --动作结束，（也谓之超时）时执行
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


-----------------------以下这部分多参照 SGwilson_client.lua  中对应的动作和内容             
--ps：当有configure时， 要对 cooldown（10） 和 timeline里的 4（starttime） 14（endtime）进行设置.  一般cooldown代表完成动作，4为前摇时间，14 为带后摇的完成时间
local mowAtDown_client= State({
    name = "mowdown",
    tags = { "doing", "busy" },

    onenter = function(inst)
		local equip = inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)		--

		--inst.sg.statemem.action = inst:GetBufferedAction()
		--ismower = inst:HasTag("mower")    --test
		inst.components.locomotor:Stop()

		local cooldown = cooldowntime * FRAMES	--client里的cooldown 基本用不到，都是随着主（非client）的cooldown，包括下面的大部分内容都会跟随主（非client）的设置执行

		if  equip:HasTag("mower")  then
--			print("执行")
			inst.AnimState:PlayAnimation("atk")								--因为尚未做动画，所以先用攻击动画
			inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_weapon")
			--inst.AnimState:PlayAnimation("mowdown")
		end

 inst:PerformPreviewBufferedAction()   ---------在client里是关键， 有这一句才能保证客户端的角色动作会执行inst:PerformBufferedAction()
 --（无论这个xxx_client 的函数里有没有inst:PerformBufferedAction()，   inst:PerformPreviewBufferedAction()  必须要有）
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

----对应上面的Addaction（） ,如果不添加action，这部分应该也是无用的
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
-----------------------(貌似ACTIONS.MOWDOWN并不会执行，而是执行的ACTIONS.PICK,所以scythe.lua里的 consumption 要用 ACTIONS.PICK)--------------

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
                                                                                                                                                                --判断是否为农作物，是的话会有"farm_plant"这个标签
--		if tool and tool:HasTag("mower") and ((action.target.prefab == "grass") or (action.target.prefab == "sapling") or (action.target.prefab == "reeds") or (action.target:HasTag("farm_plant"))) then  --新加的部分来实现在符合条件时调用镰刀的pick动作
--				return "mowdown"
		if tool and tool:HasTag("mower") and ((action.target.prefab == "grass") or (action.target.prefab == "sapling") or (action.target.prefab == "reeds") ) then  --新加的部分来实现在符合条件时调用镰刀的pick动作
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
		if tool and tool:HasTag("mower")  and ((action.target.prefab == "grass") or (action.target.prefab == "sapling") or (action.target.prefab == "reeds")) then                               --新加的部分来实现在符合条件时调用镰刀的pick动作
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

AddStategraphActionHandler("wilson", ActionHandler(ACTIONS.PICK, NewPICK))             --改写SGwilson中 actionhandlers{}中的ACTIONS.PICK 的函数为 NewPICK
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