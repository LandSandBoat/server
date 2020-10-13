-----------------------------------
-- Area: Windurst Woods
--  NPC: Ponono
-- Type: Clothcraft Guild Master
-- !pos -38.243 -2.25 -120.954 241
-- TODO Allow players to purchase additional Cuttings
-- TODO Allow players to cancel quest 
-- TODO Requre check for other 3 quests An Understanding General, A Generous General, 
-----------------------------------
local ID = require("scripts/zones/Windurst_Woods/IDs")
require("scripts/globals/crafting")
require("scripts/globals/status")
-----------------------------------

function onTrade(player, npc, trade)
    local newRank = tradeTestItem(player, npc, trade, tpz.skill.CLOTHCRAFT)
    local moralManifest = player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.A_MORAL_MANIFEST)
    local tradeGil = trade:getGil()
    if newRank ~= 0 then
        player:setSkillRank(tpz.skill.CLOTHCRAFT, newRank)
        player:startEvent(10012, 0, 0, 0, 0, newRank)
    elseif moralManifest == QUEST_ACCEPTED and player:getCharVar("moral") == 2 then
        if npcUtil.tradeHas(trade, {828, 830, {"gil", 10000}}) then -- Trade Velvet Cloth, Rainbow Cloth and 10k
            player:setCharVar("moral", 3)
            player:setLocalVar('moralZone', 1)
            player:setCharVar("moralWait", getVanaMidnight())
            player:startEvent(703)
        end
    end
end

function onTrigger(player, npc)
    local getNewRank = 0
    local craftSkill = player:getSkillLevel(tpz.skill.CLOTHCRAFT)
    local testItem = getTestItem(player, npc, tpz.skill.CLOTHCRAFT)
    local guildMember = isGuildMember(player, 3)
    local moralManifest = player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.A_MORAL_MANIFEST)
    if guildMember == 1 then
        guildMember = 10000
    end
    if canGetNewRank(player, craftSkill, tpz.skill.CLOTHCRAFT) == 1 then
        getNewRank = 100
    end
    if moralManifest == QUEST_ACCEPTED and player:getCharVar("moral") == 1 then
        player:startEvent(700)
    elseif moralManifest == QUEST_COMPLETE or moralManifest == QUEST_ACCEPTED and player:getCharVar("moral") >= 4 then
        player:startEvent(704)
    elseif player:getCharVar("moral") == 3 and player:getLocalVar("moralZone") == 0 and player:getCharVar("moralWait") <=
        os.time() then
        player:startEvent(705)
    else
        player:startEvent(10011, testItem, getNewRank, 30, guildMember, 44, 0, 0, 0)

    end
end

-- 10011  10012  700  701  702  703  704  705  832  765
function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 700 then
        player:setCharVar("moral", 2)
    elseif csid == 705 then
        if npcUtil.giveItem(player, 1867) then
            player:setCharVar("moral", 4)
        end
    elseif csid == 10011 and option == 1 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 4099)
        else
            player:addItem(4099) -- earth crystal
            player:messageSpecial(ID.text.ITEM_OBTAINED, 4099)
            signupGuild(player, guild.clothcraft)
        end
    end
end
