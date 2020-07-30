-----------------------------------
-- Area: Windurst Waters
--  NPC: Hakeem
-- Type: Cooking Image Support
-- !pos -123.120 -2.999 65.472 238
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/crafting")
local ID = require("scripts/zones/Windurst_Waters/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local guildMember = isGuildMember(player, 4)
    local SkillCap = getCraftSkillCap(player, tpz.skill.COOKING)
    local SkillLevel = player:getSkillLevel(tpz.skill.COOKING)

    if (guildMember == 1) then
        if (player:hasStatusEffect(tpz.effect.COOKING_IMAGERY) == false) then
            player:startEvent(10017, SkillCap, SkillLevel, 2, 495, player:getGil(), 0, 4095, 0) -- p1 = skill level
        else
            player:startEvent(10017, SkillCap, SkillLevel, 2, 495, player:getGil(), 7094, 4095, 0)
        end
    else
        player:startEvent(10017) -- Standard Dialogue
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 10017 and option == 1) then
        player:messageSpecial(ID.text.COOKING_SUPPORT, 0, 8, 2)
        player:addStatusEffect(tpz.effect.COOKING_IMAGERY, 1, 0, 120)
    end
end
