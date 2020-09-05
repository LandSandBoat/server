-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Tek Lengyon
-- Type: Leathercraft Synthesis Image Support
-- !pos -190.120 -2.999 2.770 230
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/crafting")
local ID = require("scripts/zones/Southern_San_dOria/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local guildMember = isGuildMember(player, 7)
    local SkillCap = getCraftSkillCap(player, tpz.skill.LEATHERCRAFT)
    local SkillLevel = player:getSkillLevel(tpz.skill.LEATHERCRAFT)

    if (guildMember == 1) then
        if (player:hasStatusEffect(tpz.effect.LEATHERCRAFT_IMAGERY) == false) then
            player:startEvent(652, SkillCap, SkillLevel, 2, 239, player:getGil(), 0, 0, 0)
        else
            player:startEvent(652, SkillCap, SkillLevel, 2, 239, player:getGil(), 7075, 0, 0)
        end
    else
        player:startEvent(652) -- Standard Dialogue
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 652 and option == 1) then
        player:messageSpecial(ID.text.LEATHER_SUPPORT, 0, 5, 2)
        player:addStatusEffect(tpz.effect.LEATHERCRAFT_IMAGERY, 1, 0, 120)
    end
end
