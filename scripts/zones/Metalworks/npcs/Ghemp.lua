-----------------------------------
-- Area: Metalworks
--  NPC: Ghemp
-- Type: Smithing Guild Master
-- !pos -109 2 27 237
-----------------------------------
local ID = require("scripts/zones/Metalworks/IDs")
require("scripts/globals/crafting")
require("scripts/globals/status")
-----------------------------------

function onTrade(player, npc, trade)
    local newRank = tradeTestItem(player, npc, trade, tpz.skill.SMITHING)

    if (newRank ~= 0) then
        player:setSkillRank(tpz.skill.SMITHING, newRank)
        player:startEvent(102, 0, 0, 0, 0, newRank)
    end
end

function onTrigger(player, npc)
    local getNewRank = 0
    local craftSkill = player:getSkillLevel(tpz.skill.SMITHING)
    local testItem = getTestItem(player, npc, tpz.skill.SMITHING)
    local guildMember = isGuildMember(player, 8)
    if (guildMember == 1) then guildMember = 150995375; end
    if (canGetNewRank(player, craftSkill, tpz.skill.SMITHING) == 1) then getNewRank = 100; end

    player:startEvent(101, testItem, getNewRank, 30, guildMember, 44, 0, 0, 0)
end

-- 908  909  910  920  927  101  102
function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 101 and option == 1) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 4096)
        else
            player:addItem(4096)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 4096) -- Fire Crystal
            signupGuild(player, guild.smithing)
        end
    end
end
