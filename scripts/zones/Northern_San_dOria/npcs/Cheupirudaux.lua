-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Cheupirudaux
-- Type: Woodworking Guildmaster NPC
-- Involved in Quest: It's Raining Mannequins!
-- !pos -138 12 250 231
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
require("scripts/globals/crafting")
require("scripts/globals/status")
-----------------------------------

function onTrade(player, npc, trade)
    local newRank = tradeTestItem(player, npc, trade, tpz.skill.WOODWORKING)

    if (newRank ~= 0) then
        player:setSkillRank(tpz.skill.WOODWORKING, newRank)
        player:startEvent(622, 0, 0, 0, 0, newRank)
    end
end

function onTrigger(player, npc)
    local getNewRank = 0
    local craftSkill = player:getSkillLevel(tpz.skill.WOODWORKING)
    local testItem = getTestItem(player, npc, tpz.skill.WOODWORKING)
    local guildMember = isGuildMember(player, 9)
    if (guildMember == 1) then guildMember = 150995375; end
    if (canGetNewRank(player, craftSkill, tpz.skill.WOODWORKING) == 1) then getNewRank = 100; end

    player:startEvent(621, testItem, getNewRank, 30, guildMember, 44, 0, 0, 0)
end

-- 621  622  759  16  0
function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 621 and option == 1) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 4098)
        else
            player:addItem(4098)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 4098) -- Wind Crystal
            signupGuild(player, guild.woodworking)
        end
    end
end
