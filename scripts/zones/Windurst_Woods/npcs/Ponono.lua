-----------------------------------
-- Area: Windurst Woods
--  NPC: Ponono
-- Type: Clothcraft Guild Master
-- !pos -38.243 -2.25 -120.954 241
-- TODO Allow players to purchase additional Cuttings
-- TODO Allow players to cancel quest
-- TODO Requre check for other 3 quests An Understanding General, A Generous General,
-- TODO: Convert this quest to interaction.
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    local moralManifest = player:getQuestStatus(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.A_MORAL_MANIFEST)

    if
        moralManifest == xi.questStatus.QUEST_ACCEPTED and
        player:getCharVar('moral') == 2 and
        npcUtil.tradeHas(trade, { 828, 830, { 'gil', 10000 } }) -- Trade Velvet Cloth, Rainbow Cloth and 10k
    then
        player:setCharVar('moral', 3)
        player:setLocalVar('moralZone', 1)
        player:setCharVar('moralWait', getVanaMidnight())
        player:startEvent(703)

    else
        xi.crafting.guildMasterOnTrade(player, npc, trade)
    end
end

entity.onTrigger = function(player, npc)
    local moralManifest = player:getQuestStatus(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.A_MORAL_MANIFEST)

    -- TODO: Convert this to interaction. The way this is coded, it WILL block you out from a guildmaster.
    if
        moralManifest == xi.questStatus.QUEST_ACCEPTED and
        player:getCharVar('moral') == 1
    then
        player:startEvent(700)

    elseif
        moralManifest == xi.questStatus.QUEST_COMPLETED or
        moralManifest == xi.questStatus.QUEST_ACCEPTED and
        player:getCharVar('moral') >= 4
    then
        player:startEvent(704)

    elseif
        player:getCharVar('moral') == 3 and
        player:getLocalVar('moralZone') == 0 and
        player:getCharVar('moralWait') <= os.time()
    then
        player:startEvent(705)

    -- Regular guildmaster logic.
    else
        xi.crafting.guildMasterOnTrigger(player, npc)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 700 then
        player:setCharVar('moral', 2)
    elseif csid == 705 then
        if npcUtil.giveItem(player, xi.item.YAGUDO_HEADDRESS_CUTTING) then
            player:setCharVar('moral', 4)
        end
    else
        xi.crafting.guildMasterOnEventFinish(player, csid, option, npc)
    end
end

return entity
