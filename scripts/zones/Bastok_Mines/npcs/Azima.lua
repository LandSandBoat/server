-----------------------------------
-- Area: Bastok Mines
--  NPC: Azima
-- Alchemy Adv. Synthesis Image Support
-- !pos 123.5 2 1 234
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/crafting")
local ID = require("scripts/zones/Bastok_Mines/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local guildMember = isGuildMember(player, 1)
    local SkillLevel = player:getSkillLevel(tpz.skill.ALCHEMY)
    local Cost = getAdvImageSupportCost(player, tpz.skill.ALCHEMY)

    if (guildMember == 1) then
        if (player:hasStatusEffect(tpz.effect.ALCHEMY_IMAGERY) == false) then
            player:startEvent(122, Cost, SkillLevel, 0, 0xB0001AF, player:getGil(), 0, 0, 0) -- Event doesn't work
        else
            player:startEvent(122, Cost, SkillLevel, 0, 0xB0001AF, player:getGil(), 0x6FE2, 0, 0)
        end
    else
        player:startEvent(122)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    local Cost = getAdvImageSupportCost(player, tpz.skill.ALCHEMY)

    if (csid == 122 and option == 1) then
        player:delGil(Cost)
        player:messageSpecial(ID.text.ALCHEMY_SUPPORT, 0, 7, 0)
        player:addStatusEffect(tpz.effect.ALCHEMY_IMAGERY, 3, 0, 480)
    end
end
