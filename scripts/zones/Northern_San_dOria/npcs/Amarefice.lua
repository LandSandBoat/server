-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Amarefice
-- Type: Woodworking Synthesis Image Support
-- !pos -181.506 10.15 259.905 231
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
            player:startEvent(624, SkillCap, SkillLevel, 1, 207, player:getGil(), 0, 4095, 0)
        else
            player:startEvent(624, SkillCap, SkillLevel, 1, 207, player:getGil(), 7127, 4095, 0)
        end
    else
        player:startEvent(624, SkillCap, SkillLevel, 1, 201, player:getGil(), 0, 0, 0) -- Standard Dialogue
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 624 and option == 1) then
        player:messageSpecial(ID.text.IMAGE_SUPPORT, 0, 1, 1)
        player:addStatusEffect(tpz.effect.WOODWORKING_IMAGERY, 1, 0, 120)
    end
end
