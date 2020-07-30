-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Ramua
-- Type: Woodworking Synthesis Image Support
-- !pos -183.750 10.999 255.770 231
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/crafting")
local ID = require("scripts/zones/Northern_San_dOria/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local guildMember = isGuildMember(player, 9)
    local SkillCap = getCraftSkillCap(player, tpz.skill.WOODWORKING)
    local SkillLevel = player:getSkillLevel(tpz.skill.WOODWORKING)

    if (guildMember == 1) then
        if (player:hasStatusEffect(tpz.effect.WOODWORKING_IMAGERY) == false) then
            player:startEvent(625, SkillCap, SkillLevel, 2, 207, player:getGil(), 0, 0, 0)
        else
            player:startEvent(625, SkillCap, SkillLevel, 2, 207, player:getGil(), 6857, 0, 0)
        end
    else
        player:startEvent(625, SkillCap, SkillLevel, 2, 201, player:getGil(), 0, 0, 0) -- Standard Dialogue
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 625 and option == 1) then
        player:messageSpecial(ID.text.IMAGE_SUPPORT, 0, 1, 2)
        player:addStatusEffect(tpz.effect.WOODWORKING_IMAGERY, 1, 0, 120)
    end
end
