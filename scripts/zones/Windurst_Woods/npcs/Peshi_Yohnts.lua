-----------------------------------
-- Area: Windurst Woods
--  NPC: Peshi Yohnts
-- Type: Bonecraft Guild Master
-- !pos -6.175 -6.249 -144.667 241
-----------------------------------
local ID = require("scripts/zones/Windurst_Woods/IDs")
require("scripts/globals/crafting")
require("scripts/globals/status")
-----------------------------------

function onTrade(player, npc, trade)
    local newRank = tradeTestItem(player, npc, trade, tpz.skill.BONECRAFT)

    if newRank ~= 0 then
        player:setSkillRank(tpz.skill.BONECRAFT, newRank)
        player:startEvent(10017, 0, 0, 0, 0, newRank)
    end
end

function onTrigger(player, npc)
    local getNewRank = 0
    local craftSkill = player:getSkillLevel(tpz.skill.BONECRAFT)
    local testItem = getTestItem(player, npc, tpz.skill.BONECRAFT)
    local guildMember = isGuildMember(player, 2)
    if guildMember == 1 then
        guildMember = 64
    end
    if canGetNewRank(player, craftSkill, tpz.skill.BONECRAFT) == 1 then
        getNewRank = 100
    end

    player:startEvent(10016, testItem, getNewRank, 30, guildMember, 44, 0, 0, 0)
end

-- 10016  10017  710  711  712  713  714  715  764
function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 10016 and option == 1 then
        local crystal = 4098 -- wind crystal

        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, crystal)
        else
            player:addItem(crystal)
            player:messageSpecial(ID.text.ITEM_OBTAINED, crystal)
            signupGuild(player, guild.bonecraft)
        end
    end
end
