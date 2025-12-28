-----------------------------------
-- Area: Hazhalm_Testing_Grounds
-- NPC: ??? (Mark of the Einherjar trades)
-- !pos 500.157 -226.821 11.089 78
-----------------------------------
local ID = zones[xi.zone.HAZHALM_TESTING_GROUNDS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if not player:hasKeyItem(xi.keyItem.MARK_OF_THE_EINHERJAR) then
        return
    end

    local feathersByTier = xi.einherjar.getFeathers(player)

    if npcUtil.tradeHasExactly(trade, { xi.item.VALKYRIES_TEAR }) then
        if #feathersByTier[xi.einherjar.wing.WING_1] < 3 then
            player:startEvent(18,
                xi.einherjar.getMissingFeathersMenu(player, xi.einherjar.wing.WING_1),
                xi.item.VALKYRIES_TEAR
            )
        end
    elseif npcUtil.tradeHasExactly(trade, { xi.item.VALKYRIES_WING }) then
        if #feathersByTier[xi.einherjar.wing.WING_2] < 3 then
            player:startEvent(18,
                xi.einherjar.getMissingFeathersMenu(player, xi.einherjar.wing.WING_2),
                xi.item.VALKYRIES_WING
            )
        end
    elseif npcUtil.tradeHasExactly(trade, { xi.item.VALKYRIES_SOUL }) then
        if #feathersByTier[xi.einherjar.wing.WING_3] < 3 then
            player:startEvent(18,
                xi.einherjar.getMissingFeathersMenu(player, xi.einherjar.wing.WING_3),
                xi.item.VALKYRIES_SOUL
            )
        end
    end
end

entity.onTrigger = function(player, npc)
    local feathersByTier = xi.einherjar.getFeathers(player)

    -- Give PC the Mark of the Einherjar if they meet any condition
    if not player:hasKeyItem(xi.ki.MARK_OF_THE_EINHERJAR) then
        -- 1. Player has the ELITE_EINHERJAR title
        if player:hasTitle(xi.title.ELITE_EINHERJAR) then
            xi.einherjar.giveMark(player)
            return
        end

        -- 2. Player has at least one feather of each tier
        if
            #feathersByTier[xi.einherjar.wing.WING_1] >= 1 and
            #feathersByTier[xi.einherjar.wing.WING_2] >= 1 and
            #feathersByTier[xi.einherjar.wing.WING_3] >= 1
        then
            xi.einherjar.giveMark(player)
            return
        end

        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
        return
    end

    if
        (player:hasItem(xi.item.VALKYRIES_TEAR) and #feathersByTier[xi.einherjar.wing.WING_1] < 3) or
        (player:hasItem(xi.item.VALKYRIES_WING) and #feathersByTier[xi.einherjar.wing.WING_2] < 3) or
        (player:hasItem(xi.item.VALKYRIES_SOUL) and #feathersByTier[xi.einherjar.wing.WING_3] < 3)
    then
        player:messageSpecial(ID.text.OTHERWORLDLY_VOICE)
        player:showText(npc, ID.text.PROVE_THY_WORTH)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 18 and option >= 1 and option <= 9 then
        xi.einherjar.giveChamberFeather(player, option)
        player:confirmTrade()
    end
end

return entity
