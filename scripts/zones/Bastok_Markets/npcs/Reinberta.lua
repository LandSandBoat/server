-----------------------------------
-- Area: Bastok Markets
--  NPC: Reinberta
-- Type: Goldsmithing Guild Master
-- !pos -190.605 -7.814 -59.432 235
-----------------------------------
local ID = require("scripts/zones/Bastok_Markets/IDs")
require("scripts/globals/crafting")
require("scripts/globals/status")
-----------------------------------

function onTrade(player, npc, trade)
    local newRank = tradeTestItem(player, npc, trade, tpz.skill.GOLDSMITHING)

    if (newRank ~= 0) then
        player:setSkillRank(tpz.skill.GOLDSMITHING, newRank)
        player:startEvent(301, 0, 0, 0, 0, newRank)
    end
end

function onTrigger(player, npc)
    local getNewRank = 0
    local craftSkill = player:getSkillLevel(tpz.skill.GOLDSMITHING)
    local testItem = getTestItem(player, npc, tpz.skill.GOLDSMITHING)
    local guildMember = isGuildMember(player, 6)
    if (guildMember == 1) then guildMember = 150995375; end
    if (canGetNewRank(player, craftSkill, tpz.skill.GOLDSMITHING) == 1) then getNewRank = 100; end

    player:startEvent(300, testItem, getNewRank, 30, guildMember, 44, 0, 0, 0)
end

-- 300  301  402
function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 300 and option == 1) then
        local crystal = 4096 -- fire crystal

        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, crystal)
        else
            player:addItem(crystal)
            player:messageSpecial(ID.text.ITEM_OBTAINED, crystal)
            signupGuild(player, guild.goldsmithing)
        end
    end
end
