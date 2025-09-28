--#region translation must
local langs = {
    ['zh'] = {
        name = "镰刀[Re-Fixed]",
        description = "镰刀和黄金镰刀, 非常棒!!",
        author = "影",
        configuration_options = {
            {
                name = "picking_rate",
                label = "收割速率",
                hover = "你可以选择使用镰刀收割的速度有多快",
                options = {
                    { description = "疯狂", data = "crazy", hover = "哇，你真的疯了！" },
                    { description = "非常快", data = "veryfast", hover = "快到你甚至看不清发生了什么" },
                    { description = "快", data = "fast", hover = "哦，节省我的时间" },
                    { description = "正常", data = "normal", hover = "比平常快一点" },
                    { description = "慢", data = "slow", hover = "为什么还要费劲呢？" },
                },
                default = "fast"
            },
            {
                name = "durability",
                label = "耐久度",
                hover = "你可以选择镰刀使用的次数",
                options = {
                    { description = "正常", data = "normal", hover = "镰刀/黄金镰刀可使用 25/100 次" },
                    { description = "好", data = "good", hover = "镰刀/黄金镰刀可使用 40/160 次" },
                    { description = "良好", data = "fine", hover = "镰刀/黄金镰刀可使用 50/200 次" },
                    { description = "优秀", data = "excellent", hover = "镰刀/黄金镰刀可使用 75/300 次" },
                    { description = "耐用", data = "durable", hover = "镰刀/黄金镰刀可使用 125/500 次" },
                },
                default = "fine"
            },
            {
                name = "mow_farmplant",
                label = "农场植物",
                hover = "你可以使用镰刀收割农场植物吗",
                options = {
                    { description = "是", data = "yes", hover = "我们的农业效率提高了" },
                    { description = "否", data = "no", hover = "我们可以用手处理它们" },
                },
                default = "no"
            },

            {
                name = "mow_berrybush",
                label = "浆果灌木丛",
                hover = "你可以使用镰刀采集浆果吗",
                options = {
                    { description = "是", data = "yes", hover = "我们的采集效率提高了" },
                    { description = "否", data = "no", hover = "我们可以用手处理它们" },
                },
                default = "no"
            },
            {
                name = "mow_rock_avocado_bush",
                label = "岩石牛油果果树",
                hover = "你可以使用镰刀收获石果吗",
                options = {
                    { description = "是", data = "yes", hover = "我们的收获效率提高了" },
                    { description = "否", data = "no", hover = "我们可以用手处理它们" },
                },
                default = "no"
            }
        }
    }
}
langs['zht'], langs['zhr'] = langs.zh, langs.zh

--#endregion

name = "Scythestest[Re-Fixed]"
description = "Scythe and GoldenScythe, nice!"
author = "Captain_M"
version = "2.46"

-- forumthread = "https://steamcommunity.com/sharedfiles/filedetails/?id=2963262385&tscn=1700009031"
forumthread = ""

api_version = 10
all_clients_require_mod = true
client_only_mod = false
dst_compatible = true

icon_atlas = "scythe.xml"
icon = "scythe.tex"

configuration_options = {
    {
        name = "picking_rate",
        label = "Picking Rate",
        hover = "You can choose how fast you want picking with scythes",
        options = {
            { description = "Crazy", data = "crazy", hover = "Ya, you are crazy!" },
            { description = "Very fast", data = "veryfast", hover = "So fast that you can't even see what happened" },
            { description = "Fast", data = "fast", hover = "Oh, saving my time" },
            { description = "Normal", data = "normal", hover = "Faster then usual picking" },
            { description = "Slow", data = "slow", hover = "Why even bother?" },
        },
        default = "fast"
    },

    {
        name = "durability",
        label = "Durability",
        hover = "You can choose how much times the scythes can be use",
        options = {
            { description = "Normal", data = "normal", hover = "Scythes/GoldenScythes can be use 25/100 times" },
            { description = "Good", data = "good", hover = "Scythes/GoldenScythes can be use 40/160 times" },
            { description = "Fine", data = "fine", hover = "Scythes/GoldenScythes can be use 50/200 times" },
            { description = "Excellent", data = "excellent", hover = "Scythes/GoldenScythes can be use 75/300 times" },
            { description = "Durable", data = "durable", hover = "Scythes/GoldenScythes can be use 125/500 times" },
        },
        default = "fine"
    },

    {
        name = "mow_farmplant",
        label = "FarmPlant",
        hover = "You can use scythes to reap Farmplant or not",
        options = {
            { description = "Yes", data = "yes", hover = "Our farming efficiency's improving" },
            { description = "No", data = "no", hover = "We can handler it by our hands" },
        },
        default = "no"
    },

    {
        name = "mow_berrybush",
        label = "Berrybush",
        hover = "You can use scythes to gather Berries or not",
        options = {
            { description = "Yes", data = "yes", hover = "Our gathering efficiency's improving" },
            { description = "No", data = "no", hover = "We can handler it by our hands" },
        },
        default = "no"
    },

    {
        name = "mow_rock_avocado_bush",
        label = "Rock Avocado",
        hover = "You can use scythes to harvest Stonefruit or not",
        options = {
            { description = "Yes", data = "yes", hover = "Our harvesting efficiency's improving" },
            { description = "No", data = "no", hover = "We can handler it by our hands" },
        },
        default = "no"
    }
}

---@diagnostic disable-next-line: undefined-global
local lang = langs[locale or 'en']
if lang then
    if lang.name then
        name = lang.name
    end
    if lang.author then
        author = lang.author
    end

    if lang.description then
        description = lang.description
    end

    if lang.configuration_options then
        configuration_options = lang.configuration_options
    end
end
