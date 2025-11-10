-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Venessa
-----------------------------------
local entity = {}

local rewardMap =
{
    [xi.item.BRILLIANT_VISION  ] = xi.item.SUMMONING_EARRING,
    [xi.item.PAINFUL_VISION    ] = xi.item.DARK_EARRING,
    [xi.item.TIMOROUS_VISION   ] = xi.item.ENFEEBLING_EARRING,
    [xi.item.VENERABLE_VISION  ] = xi.item.STRING_EARRING,
    [xi.item.VIOLENT_VISION    ] = xi.item.BUCKLER_EARRING,
    [xi.item.AUDACIOUS_VISION  ] = xi.item.DIVINE_EARRING,
    [xi.item.ENDEARING_VISION  ] = xi.item.SINGING_EARRING,
    [xi.item.PUNCTILIOUS_VISION] = xi.item.PARRYING_EARRING,
    [xi.item.VERNAL_VISION     ] = xi.item.EVASION_EARRING,
    [xi.item.VIVID_VISION      ] = xi.item.HEALING_EARRING,
    [xi.item.MALICIOUS_VISION  ] = xi.item.NINJUTSU_EARRING,
    [xi.item.PRETENTIOUS_VISION] = xi.item.ELEMENTAL_EARRING,
    [xi.item.PRISTINE_VISION   ] = xi.item.WIND_EARRING,
    [xi.item.SOLEMN_VISION     ] = xi.item.GUARDING_EARRING,
    [xi.item.VALIANT_VISION    ] = xi.item.AUGMENTING_EARRING,
    [xi.item.IMPETUOUS_VISION  ] = xi.item.TOREADORS_RING,
    [xi.item.TENUOUS_VISION    ] = xi.item.ASTRAL_ROPE,
    [xi.item.SNIDE_VISION      ] = xi.item.SAFETY_MANTLE,
    [xi.item.GRAVE_IMAGE       ] = xi.item.PIECE_OF_HABU_SKIN,
    [xi.item.BEATIFIC_IMAGE    ] = xi.item.TIGER_EYE,
    [xi.item.VALOROUS_IMAGE    ] = xi.item.SQUARE_OF_RHEIYOH_LEATHER,
    [xi.item.ANCIENT_IMAGE     ] = xi.item.OVERSIZED_FANG,
    [xi.item.VIRGIN_IMAGE      ] = xi.item.CHUNK_OF_SUPER_CERMET,
}

-- ENM configuration table
local enmTable =
{
    [1] = { keyItem = xi.ki.CENSER_OF_ABANDONMENT, timer = '[ENM]abandonmentTimer' }, -- Simulant
    [2] = { keyItem = xi.ki.CENSER_OF_ANTIPATHY,   timer = '[ENM]antipathyTimer'   }, -- You Are What You Eat
    [3] = { keyItem = xi.ki.CENSER_OF_ANIMUS,      timer = '[ENM]animusTimer'      }, -- Playing Host
    [4] = { keyItem = xi.ki.CENSER_OF_ACRIMONY,    timer = '[ENM]acrimonyTimer'    }, -- Pulling the Plug
}

entity.onTrade = function(player, npc, trade)
    if trade:getItemCount() ~= 1 then
        return
    end

    local tradedItem = trade:getItemId(0)
    local reward     = rewardMap[tradedItem]
    if reward and npcUtil.tradeHasExactly(trade, tradedItem) then
        -- Store for validation in onEventFinish
        player:setLocalVar('veneReward', reward)
        player:startEvent(10066, reward)
    end
end

entity.onTrigger = function(player, npc)
    local copProgress = player:getCurrentMission(xi.mission.log_id.COP)
    local eventId     = player:hasCompletedUniqueEvent(xi.uniqueEvent.VANESSA_ENM_COMPLETE) == 1 and 10065 or 10064 -- 10064: Player is new to Venessa, 10065: Spoke with Venessa

    -- Before unlocking first 3 Promyvions.
    if copProgress <= xi.mission.id.cop.THE_RITES_OF_LIFE then
        player:startEvent(10064, { [0] = 99 })

    -- Before unlocking Promyvions-Vahzl.
    elseif copProgress <= xi.mission.id.cop.SLANDEROUS_UTTERINGS then
        player:startEvent(eventId, { [0] = 16, [5] = 6, [6] = 1 })

    -- All 4 Promyvions unlocked.
    else
        player:startEvent(eventId)
    end
end

entity.onEventUpdate = function(player, csid, option)
    -- Not allowed events.
    if
        (csid ~= 10064 and csid ~= 10065) or
        option < 1 or
        option > 4
    then
        return
    end

    local enmData = enmTable[option]
    local timer   = player:getCharVar(enmData.timer)

    -- Show time remaining if KI used, otherwise just indicate they have it
    if VanadielTime() < timer then
        if not player:hasKeyItem(enmData.keyItem) then
            player:updateEvent(option, 0, 0, 0, timer, 1)
        else
            player:updateEvent(option)
        end

    -- Cooldown complete, KI available
    else
        player:updateEvent(option, 0, 0, 1)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    -- Trade Event.
    if csid == 10066 then
        local reward = player:getLocalVar('veneReward')
        player:setLocalVar('veneReward', 0)

        if
            reward > 0 and
            npcUtil.giveItem(player, reward)
        then
            player:tradeComplete()
        end

        return
    end

    -- Not allowed events.
    if
        (csid ~= 10064 and csid ~= 10065) or
        option < 1 or
        option > 4
    then
        return
    end

    local enmData = enmTable[option]
    local timer   = player:getCharVar(enmData.timer)

    -- Set timer before giving KI to prevent disconnect exploit
    if
        VanadielTime() >= timer and
        not player:hasKeyItem(enmData.keyItem)
    then
        player:setCharVar(enmData.timer, VanadielTime() + xi.settings.main.ENM_COOLDOWN * 3600)
        player:setUniqueEvent(xi.uniqueEvent.VANESSA_ENM_COMPLETE)
        npcUtil.giveKeyItem(player, enmData.keyItem)
    end
end

return entity
