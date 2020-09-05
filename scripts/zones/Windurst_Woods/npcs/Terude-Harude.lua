-----------------------------------
-- Area: Windurst Woods
--  NPC: Terude-Harude
-- Type: Clothcraft Adv. Image Support
-- !pos -32.350 -2.679 -116.450 241
-----------------------------------
local ID = require("scripts/zones/Windurst_Woods/IDs")
require("scripts/globals/crafting")
require("scripts/globals/status")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local guildMember = isGuildMember(player, 3)
    local SkillLevel = player:getSkillLevel(tpz.skill.CLOTHCRAFT)
    local Cost = getAdvImageSupportCost(player, tpz.skill.CLOTHCRAFT)

    if guildMember == 1 then
        if not player:hasStatusEffect(tpz.effect.CLOTHCRAFT_IMAGERY) then
            player:startEvent(10013, Cost, SkillLevel, 0, 511, player:getGil(), 0, 4095, 0)
        else
            player:startEvent(10013, Cost, SkillLevel, 0, 511, player:getGil(), 28754, 0, 0)
        end
    else
        player:startEvent(10013) -- Standard Dialogue
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    local Cost = getAdvImageSupportCost(player, 8)
    if csid == 10013 and option == 1 then
        player:delGil(Cost)
        player:messageSpecial(ID.text.IMAGE_SUPPORT, 0, 4, 0)
        player:addStatusEffect(tpz.effect.CLOTHCRAFT_IMAGERY, 3, 0, 480)
    end
end
