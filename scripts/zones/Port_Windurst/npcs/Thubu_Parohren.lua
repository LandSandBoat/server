-----------------------------------
-- Area: Port Windurst
--  NPC: Thubu Parohren
-- Type: Fishing Guild Master
-- !pos -182.230 -3.835 61.373 240
-----------------------------------
local ID = require("scripts/zones/Port_Windurst/IDs")
require("scripts/globals/crafting")
require("scripts/globals/status")
-----------------------------------

function onTrade(player, npc, trade)
    local newRank = tradeTestItem(player, npc, trade, tpz.skill.FISHING)

    if (newRank ~= 0) then
        player:setSkillRank(tpz.skill.FISHING, newRank)
        player:startEvent(10010, 0, 0, 0, 0, newRank)
    end
end

function onTrigger(player, npc)
    local getNewRank = 0
    local craftSkill = player:getSkillLevel(tpz.skill.FISHING)
    local testItem = getTestItem(player, npc, tpz.skill.FISHING)
    local guildMember = isGuildMember(player, 5)
    if (guildMember == 1) then guildMember = 150995375; end
    if (canGetNewRank(player, craftSkill, tpz.skill.FISHING) == 1) then getNewRank = 100; end

    player:startEvent(10009, testItem, getNewRank, 30, guildMember, 44, 0, 0, 0)
end

-- 10009  10010  595  597
function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 10009 and option == 1) then
        local crystal = 4101 -- water crystal

        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, crystal)
        else
            player:addItem(crystal)
            player:messageSpecial(ID.text.ITEM_OBTAINED, crystal)
            signupGuild(player, guild.fishing)
        end
    end
end
