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
require("scripts/globals/items")
require("scripts/globals/roe")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local signed        = trade:getItem():getSignature() == player:getName() and 1 or 0
    local newRank       = xi.crafting.tradeTestItem(player, npc, trade, xi.skill.CLOTHCRAFT)
    local moralManifest = player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.A_MORAL_MANIFEST)

    if
        newRank > 9 and
        player:getCharVar("ClothcraftExpertQuest") == 1 and
        player:hasKeyItem(xi.keyItem.WAY_OF_THE_WEAVER)
    then
        if signed ~= 0 then
            player:setSkillRank(xi.skill.CLOTHCRAFT, newRank)
            player:startEvent(10012, 0, 0, 0, 0, newRank, 1)
            player:setCharVar("ClothcraftExpertQuest", 0)
            player:setLocalVar("ClothcraftTraded", 1)
        else
            player:startEvent(10012, 0, 0, 0, 0, newRank, 0)
        end
    elseif newRank ~= 0 and newRank <= 9 then
        player:setSkillRank(xi.skill.CLOTHCRAFT, newRank)
        player:startEvent(10012, 0, 0, 0, 0, newRank)
        player:setLocalVar("ClothcraftTraded", 1)
    elseif moralManifest == QUEST_ACCEPTED and player:getCharVar("moral") == 2 then
        if npcUtil.tradeHas(trade, { 828, 830, { "gil", 10000 } }) then -- Trade Velvet Cloth, Rainbow Cloth and 10k
            player:setCharVar("moral", 3)
            player:setLocalVar('moralZone', 1)
            player:setCharVar("moralWait", getVanaMidnight())
            player:startEvent(703)
        end
    end
end

entity.onTrigger = function(player, npc)
    local moralManifest = player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.A_MORAL_MANIFEST)

    local craftSkill        = player:getSkillLevel(xi.skill.CLOTHCRAFT)
    local testItem          = xi.crafting.getTestItem(player, npc, xi.skill.CLOTHCRAFT)
    local guildMember       = xi.crafting.hasJoinedGuild(player, xi.crafting.guild.CLOTHCRAFT) and 10000 or 0
    local rankCap           = xi.crafting.getCraftSkillCap(player, xi.skill.CLOTHCRAFT)
    local expertQuestStatus = 0
    local rank              = player:getSkillRank(xi.skill.CLOTHCRAFT)
    local realSkill         = (craftSkill - rank) / 32

    if xi.crafting.unionRepresentativeTriggerRenounceCheck(player, 10011, realSkill, rankCap, 184549887) then
        return
    end

    if player:getCharVar("ClothcraftExpertQuest") == 1 then
        if player:hasKeyItem(xi.keyItem.WAY_OF_THE_WEAVER) then
            expertQuestStatus = 600
        else
            expertQuestStatus = 550
        end
    end

    if moralManifest == QUEST_ACCEPTED and player:getCharVar("moral") == 1 then
        player:startEvent(700)
    elseif
        moralManifest == QUEST_COMPLETED or
        moralManifest == QUEST_ACCEPTED and
        player:getCharVar("moral") >= 4
    then
        player:startEvent(704)
    elseif
        player:getCharVar("moral") == 3 and
        player:getLocalVar("moralZone") == 0 and
        player:getCharVar("moralWait") <= os.time()
    then
        player:startEvent(705)
    else
        player:startEvent(10011, testItem, realSkill, rankCap, guildMember, expertQuestStatus, 0, 0, 0)
    end
end

-- 10011  10012  700  701  702  703  704  705  832  765
entity.onEventUpdate = function(player, csid, option)
    if
        csid == 10011 and
        option >= xi.skill.WOODWORKING and
        option <= xi.skill.COOKING
    then
        xi.crafting.unionRepresentativeEventUpdateRenounce(player, option)
    end
end

entity.onEventFinish = function(player, csid, option)
    if csid == 700 then
        player:setCharVar("moral", 2)
    elseif csid == 705 then
        if npcUtil.giveItem(player, xi.items.YAGUDO_HEADDRESS_CUTTING) then
            player:setCharVar("moral", 4)
        end
    elseif csid == 10011 and option == 2 then
        if xi.crafting.hasJoinedGuild(player, xi.crafting.guild.CLOTHCRAFT) then
            player:setCharVar("ClothcraftExpertQuest", 1)
        end
    elseif csid == 10011 and option == 1 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.items.EARTH_CRYSTAL)
        else
            player:addItem(4099) -- earth crystal
            player:messageSpecial(ID.text.ITEM_OBTAINED, xi.items.EARTH_CRYSTAL)
            xi.crafting.signupGuild(player, xi.crafting.guild.CLOTHCRAFT)
        end
    else
        if player:getLocalVar("ClothcraftTraded") == 1 then
            player:tradeComplete()
            player:setLocalVar("ClothcraftTraded", 0)
        end
    end

    if player:hasEminenceRecord(103) then
        xi.roe.onRecordTrigger(player, 103)
    end
end

return entity
