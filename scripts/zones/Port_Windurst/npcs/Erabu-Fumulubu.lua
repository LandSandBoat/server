-----------------------------------
-- Area: Port Windurst
--  NPC: Erabu-Fumulubu
-- Type: Fishing Synthesis Image Support
-- !pos -178.900 -2.789 76.200 240
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
            player:startEvent(10012, SkillCap, SkillLevel, 1, 239, player:getGil(), 0, 0, 0) -- p1 = skill level
        else
            player:startEvent(10012, SkillCap, SkillLevel, 1, 239, player:getGil(), 19194, 4031, 0)
        end
    else
        player:startEvent(10012) -- Standard Dialogue
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 10012 and option == 1) then
        player:messageSpecial(ID.text.FISHING_SUPPORT, 0, 0, 1)
        player:addStatusEffect(tpz.effect.FISHING_IMAGERY, 1, 0, 3600)
    end
end
