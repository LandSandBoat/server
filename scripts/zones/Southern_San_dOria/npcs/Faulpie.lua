-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Faulpie
-- Type: Leathercraft Guild Master
-- !pos -178.882 -2 9.891 230
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
require("scripts/globals/crafting")
require("scripts/globals/missions")
require("scripts/globals/status")
-----------------------------------

function onTrade(player, npc, trade)
    local newRank = tradeTestItem(player, npc, trade, tpz.skill.LEATHERCRAFT)

    if (newRank ~= 0) then
        player:setSkillRank(tpz.skill.LEATHERCRAFT, newRank)
        player:startEvent(649, 0, 0, 0, 0, newRank)
    end
end

function onTrigger(player, npc)
    local getNewRank = 0
    local craftSkill = player:getSkillLevel(tpz.skill.LEATHERCRAFT)
    local testItem = getTestItem(player, npc, tpz.skill.LEATHERCRAFT)
    local guildMember = isGuildMember(player, 7)
    if (guildMember == 1) then guildMember = 150995375; end
    if (canGetNewRank(player, craftSkill, tpz.skill.LEATHERCRAFT) == 1) then getNewRank = 100; end

    if (player:getCurrentMission(ASA) == tpz.mission.id.asa.THAT_WHICH_CURDLES_BLOOD and guildMember == 150995375 and
        getNewRank ~= 100) then
        local item = 0
        local asaStatus = player:getCharVar("ASA_Status")

        -- TODO: Other Enfeebling Kits
        if (asaStatus == 0) then
            item = 2779
        else
            printf("Error: Unknown ASA Status Encountered <%u>", asaStatus)
        end

        -- The Parameters are Item IDs for the Recipe
        player:startEvent(944, item, 2773, 917, 917, 2776, 4103)
    else
        player:startEvent(648, testItem, getNewRank, 30, guildMember, 44, 0, 0, 0)
    end
end

-- 648  649  760  761  762  763  764  765  770  771  772  773  774  775  944  914
function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 648 and option == 1) then
        local crystal = 4103 -- dark crystal

        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, crystal)
        else
            player:addItem(crystal)
            player:messageSpecial(ID.text.ITEM_OBTAINED, crystal)
            signupGuild(player, guild.leathercraft)
        end
    end
end
