-----------------------------------
-- Area: Mhaura
--  NPC: Fyi_Chalmwoh
-- !pos -39.273 -16.000 70.126 249
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    --local rainingMannequins = player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.ITS_RAINING_MANNEQUINS)
    --if rainingMannequins == QUEST_COMPLETED then
    --    if
    --        (npcUtil.tradeHasExactly(trade, { xi.item.HUME_M_MANNEQUIN }) or
    --        npcUtil.tradeHasExactly(trade, { xi.item.HUME_F_MANNEQUIN }) or
    --        npcUtil.tradeHasExactly(trade, { xi.item.ELVAAN_M_MANNEQUIN }) or
    --        npcUtil.tradeHasExactly(trade, { xi.item.ELVAAN_F_MANNEQUIN }) or
    --        npcUtil.tradeHasExactly(trade, { xi.item.TARUTARU_M_MANNEQUIN }) or
    --        npcUtil.tradeHasExactly(trade, { xi.item.TARUTARU_F_MANNEQUIN }) or
    --        npcUtil.tradeHasExactly(trade, { xi.item.MITHRA_MANNEQUIN }) or
    --        npcUtil.tradeHasExactly(trade, { xi.item.GALKA_MANNEQUIN })) and
    --        player:getGil() >= 2000
    --    then
    --        player:startEvent(319, 2, 0, 100000, 2000, 0, 0, 4095, 0)
    --    end
    --end
end

entity.onTrigger = function(player, npc)
    -- Interaction framework falls through to here if you've completed the quests:
    --local rainingMannequins = player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.ITS_RAINING_MANNEQUINS)

    -- Mannequin shop + exchange
    -- TODO: When you try to buy a new one, mannequins you already own aren't available
    -- TODO: Check money
    --if rainingMannequins == QUEST_COMPLETED then
    --    local alreadyOwnedMask = 0
    --    player:startEvent(318, 0, alreadyOwnedMask, 100000, 2000, 0, 0, 0, 0)
    --end

    -- cs 320: Asking about Red Oil
    -- cs 321: Buy / Trade mannequins
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    --local itemId = 255 + option
    --local race = player:getRace()

    --local pose = 0
    -- Posing:
    -- 0x00: Normal Pose
    -- 0x01: Sitting
    -- 0x02: Salute Sand'Oria
    -- 0x03: Salute Bastok
    -- 0x04: Salute Windurst
    -- 0x05 -> 0x07: <blank, mannequin disappears>
    -- 0x08: Hurray!
    -- 0x09 -> 0x0E: <blank, same as Hurray!, maybe different hand positions depending on weapon?>
    -- 0x0F: <blank, mannequin disappears>
    -- 0x10: "Superhero landing"
    -- TODO: Map this space
    -- 0x20: "Superhero landing"

    -- TODO: Map the 0x20 -> 0xFF
    -- TODO: Capture "Special Order" pose

    --if csid == 318 then
    --    -- A mannequin will not function without exdata[18] correctly set!
    --    player:addItem({ id = itemId, exdata = { [18] = race, [19] = pose } })
    --end
end

return entity
