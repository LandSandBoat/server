-----------------------------------
-- Area: Metalworks
--  NPC: Romero
-- Type: Smithing Synthesis Image Support
-- !pos -106.336 2.000 26.117 237
-----------------------------------
local ID = require("scripts/zones/Metalworks/IDs")
require("scripts/globals/status")
require("scripts/globals/crafting")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local guildMember = isGuildMember(player, 8)
    local SkillCap = getCraftSkillCap(player, tpz.skill.SMITHING)
    local SkillLevel = player:getSkillLevel(tpz.skill.SMITHING)

    if guildMember == 1 then
        if player:hasStatusEffect(tpz.effect.SMITHING_IMAGERY) == false then
            player:startEvent(105, SkillCap, SkillLevel, 2, 207, player:getGil(), 0, 0, 0)
        else
            player:startEvent(105, SkillCap, SkillLevel, 2, 207, player:getGil(), 7127, 0, 0)
        end
    else
        player:startEvent(105)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 105 and option == 1 then
        player:delStatusEffectsByFlag(tpz.effectFlag.SYNTH_SUPPORT, true)
        player:addStatusEffect(tpz.effect.SMITHING_IMAGERY, 1, 0, 120)
        player:messageSpecial(ID.text.SMITHING_SUPPORT, 0, 2, 2)
    end
end
