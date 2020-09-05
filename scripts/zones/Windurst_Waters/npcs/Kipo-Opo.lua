-----------------------------------
-- Area: Windurst Waters
--  NPC: Kipo-Opo
-- Type: Cooking Adv. Image Support
-- !pos -119.750 -5.239 64.500 238
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/crafting")
local ID = require("scripts/zones/Windurst_Waters/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local guildMember = isGuildMember(player, 4)
    local SkillLevel = player:getSkillLevel(tpz.skill.COOKING)
    local Cost = getAdvImageSupportCost(player, tpz.skill.COOKING)

    if (guildMember == 1) then
        if (player:hasStatusEffect(tpz.effect.COOKING_IMAGERY) == false) then
            player:startEvent(10015, Cost, SkillLevel, 0, 495, player:getGil(), 0, 0, 0) -- p1 = skill level
        else
            player:startEvent(10015, Cost, SkillLevel, 0, 495, player:getGil(), 28589, 0, 0)
        end
    else
        player:startEvent(10015) -- Standard Dialogue
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    local Cost = getAdvImageSupportCost(player, tpz.skill.COOKING)

    if (csid == 10015 and option == 1) then
        player:delGil(Cost)
        player:messageSpecial(ID.text.COOKING_SUPPORT, 0, 8, 0)
        player:addStatusEffect(tpz.effect.COOKING_IMAGERY, 3, 0, 480)
    end
end
