-----------------------------------
-- Area: Windurst Woods
--  NPC: Ponono
-- Type: Clothcraft Guild Master
-- !pos -38.243 -2.25 -120.954 241
-----------------------------------
local ID = require("scripts/zones/Windurst_Woods/IDs")
require("scripts/globals/crafting")
require("scripts/globals/status")
-----------------------------------

function onTrade(player, npc, trade)
    local newRank = tradeTestItem(player, npc, trade, tpz.skill.CLOTHCRAFT)

    if newRank ~= 0 then
        player:setSkillRank(tpz.skill.CLOTHCRAFT, newRank)
        player:startEvent(10012, 0, 0, 0, 0, newRank)
    end
end

function onTrigger(player, npc)
    local getNewRank = 0
    local craftSkill = player:getSkillLevel(tpz.skill.CLOTHCRAFT)
    local testItem = getTestItem(player, npc, tpz.skill.CLOTHCRAFT)
    local guildMember = isGuildMember(player, 3)
    if guildMember == 1 then
        guildMember = 10000
    end
    if canGetNewRank(player, craftSkill, tpz.skill.CLOTHCRAFT) == 1 then
        getNewRank = 100
    end

    player:startEvent(10011, testItem, getNewRank, 30, guildMember, 44, 0, 0, 0)
end

-- 10011  10012  700  701  702  703  704  705  832  765
function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 10011 and option == 1 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 4099)
        else
            player:addItem(4099) -- earth crystal
            player:messageSpecial(ID.text.ITEM_OBTAINED, 4099)
            signupGuild(player, guild.clothcraft)
        end
    end
end
