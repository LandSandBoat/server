-----------------------------------
-- Area: Port Windurst
--  NPC: Degong
-- Type: Fishing Synthesis Image Support
-- !pos -178.400 -3.835 60.480 240
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/crafting")
local ID = require("scripts/zones/Port_Windurst/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local guildMember = isGuildMember(player, 5)
    local SkillCap = getCraftSkillCap(player, tpz.skill.FISHING)
    local SkillLevel = player:getSkillLevel(tpz.skill.FISHING)

    if (guildMember == 1) then
        if (player:hasStatusEffect(tpz.effect.FISHING_IMAGERY) == false) then
            player:startEvent(10013, SkillCap, SkillLevel, 2, 239, player:getGil(), 0, 30, 0) -- p1 = skill level
        else
            player:startEvent(10013, SkillCap, SkillLevel, 2, 239, player:getGil(), 19293, 30, 0)
        end
    else
        player:startEvent(10013) -- Standard Dialogue
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 10013 and option == 1) then
        player:messageSpecial(ID.text.FISHING_SUPPORT, 0, 0, 2)
        player:addStatusEffect(tpz.effect.FISHING_IMAGERY, 1, 0, 3600)
    end
end
