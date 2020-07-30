-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Greubaque
-- Type: Smithing Adv. Synthesis Image Support
-- !pos -179.400 10.999 150.000 231
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/crafting")
local ID = require("scripts/zones/Northern_San_dOria/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local guildMember = isGuildMember(player, 8)
    local SkillLevel = player:getSkillLevel(tpz.skill.SMITHING)
    local Cost = getAdvImageSupportCost(player, tpz.skill.SMITHING)

    if (guildMember == 1) then
        if (player:hasStatusEffect(tpz.effect.SMITHING_IMAGERY) == false) then
            player:startEvent(628, Cost, SkillLevel, 0, 205, player:getGil(), 0, 0, 0)
        else
            player:startEvent(628, Cost, SkillLevel, 0, 205, player:getGil(), 28721, 4095, 0)
        end
    else
        player:startEvent(628, Cost, SkillLevel, 0, 201, player:getGil(), 0, 26, 0) -- Standard Dialogue
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    local Cost = getAdvImageSupportCost(player, tpz.skill.SMITHING)

    if (csid == 628 and option == 1) then
        player:delGil(Cost)
        player:messageSpecial(ID.text.IMAGE_SUPPORT, 0, 2, 0)
        player:addStatusEffect(tpz.effect.SMITHING_IMAGERY, 3, 0, 480)
    end
end
