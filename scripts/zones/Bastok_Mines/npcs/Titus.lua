-----------------------------------
-- Area: Bastok Mines
--  NPC: Titus
-- Alchemy Synthesis Image Support
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/crafting")
local ID = require("scripts/zones/Bastok_Mines/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local guildMember = isGuildMember(player, 1)
    local SkillCap = getCraftSkillCap(player, tpz.skill.ALCHEMY)
    local SkillLevel = player:getSkillLevel(tpz.skill.ALCHEMY)

    if (guildMember == 1) then
        if (player:hasStatusEffect(tpz.effect.ALCHEMY_IMAGERY) == false) then
            player:startEvent(123, SkillCap, SkillLevel, 1, 137, player:getGil(), 0, 0, 0)
        else
            player:startEvent(123, SkillCap, SkillLevel, 1, 137, player:getGil(), 6758, 0, 0)
        end
    else
        player:startEvent(123)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 123 and option == 1) then
        player:messageSpecial(ID.text.ALCHEMY_SUPPORT, 0, 7, 1)
        player:addStatusEffect(tpz.effect.ALCHEMY_IMAGERY, 1, 0, 120)
    end
end
