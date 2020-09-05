-----------------------------------
-- Area: Windurst Waters
--  NPC: Piketo-Puketo
-- Type: Cooking Guild Master
-- !pos -124.012 -2.999 59.998 238
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters/IDs")
require("scripts/globals/crafting")
require("scripts/globals/status")
-----------------------------------

function onTrade(player, npc, trade)
    local newRank = tradeTestItem(player, npc, trade, tpz.skill.COOKING)

    if (newRank ~= 0) then
        player:setSkillRank(tpz.skill.COOKING, newRank)
        player:startEvent(10014, 0, 0, 0, 0, newRank)
    end
end

function onTrigger(player, npc)
    local getNewRank = 0
    local craftSkill = player:getSkillLevel(tpz.skill.COOKING)
    local testItem = getTestItem(player, npc, tpz.skill.COOKING)
    local guildMember = isGuildMember(player, 4)
    if (guildMember == 1) then guildMember = 150995375; end
    if (canGetNewRank(player, craftSkill, tpz.skill.COOKING) == 1) then getNewRank = 100; end

    player:startEvent(10013, testItem, getNewRank, 30, guildMember, 44, 0, 0, 0)
end

-- 978  983  980  981  10013  10014
function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 10013 and option == 1) then
        local crystal = 4096 -- fire crystal

        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, crystal)
        else
            player:addItem(crystal)
            player:messageSpecial(ID.text.ITEM_OBTAINED, crystal)
            signupGuild(player, guild.cooking)
        end
    end
end
