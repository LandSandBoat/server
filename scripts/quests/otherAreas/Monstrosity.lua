-----------------------------------
-- Monstrosity
-- The Suspicious NPCs and Odyssean Passages are in scripts/globals/monstrosity/city.lua. The quest's
-- priority events win over them until it is complete.
-----------------------------------
-- Log ID: 4, Quest ID: 34
-- Suspicious Hume     : !pos -491.817 24.988 -618.552 109
-- Suspicious Elvaan   : !pos 82.217 -0.199 42.682 231
-- Suspicious Galka    : !pos 81.610 8.499 -229.065 236
-- Suspicious Tarutaru : !pos 221.286 -12.000 225.311 240
-- Rabbit Hide         : !additem 856
-- Lizard Tail         : !additem 926
-- Two-leaf Mandy Bud  : !additem 4368
-----------------------------------

local quest = Quest:new(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.MONSTROSITY)

quest.reward = {}

local tradeItems =
{
    { xi.item.LIZARD_TAIL,             xi.monstrositySpecies.LIZARD     },
    { xi.item.RABBIT_HIDE,             xi.monstrositySpecies.RABBIT     },
    { xi.item.TWO_LEAF_MANDRAGORA_BUD, xi.monstrositySpecies.MANDRAGORA },
}

local suspiciousCityNpc =
{
    onTrade = function(player, npc, trade)
        if player:hasKeyItem(xi.keyItem.RING_OF_SUPERNAL_DISJUNCTION) then
            return
        end

        for _, entry in ipairs(tradeItems) do
            local itemId = entry[1]
            if npcUtil.tradeMatches(trade, { { itemId, 1 } }) then
                player:setLocalVar('MONSTROSITY_UNLOCK', entry[2])
                return quest:progressEvent(xi.monstrosity.cityEvents[player:getZoneID()] + xi.monstrosity.cityEvent.TRADE, itemId)
            end
        end
    end,

    onTrigger = function(player, npc)
        local baseEvent = xi.monstrosity.cityEvents[player:getZoneID()]

        if not player:hasKeyItem(xi.keyItem.RING_OF_SUPERNAL_DISJUNCTION) then
            return quest:priorityEvent(baseEvent + xi.monstrosity.cityEvent.INTRO)
        else
            return quest:priorityEvent(baseEvent + xi.monstrosity.cityEvent.HAS_RING)
        end
    end,
}

local function tradeEventFinish(player, csid, option, npc)
    local species = player:getLocalVar('MONSTROSITY_UNLOCK')
    player:setLocalVar('MONSTROSITY_UNLOCK', 0)

    if
        species == 0 or
        not player:tradeComplete()
    then
        return
    end

    npcUtil.giveKeyItem(player, xi.keyItem.RING_OF_SUPERNAL_DISJUNCTION)
    player:setMonstrosityData({ monstrosityId = species, species = species })
end

quest.sections =
{
    {
        check = function(player, status, vars)
            return xi.settings.main.ENABLE_MONSTROSITY == 1 and status == xi.questStatus.QUEST_AVAILABLE
        end,

        [xi.zone.PASHHOW_MARSHLANDS] =
        {
            ['Suspicious_Hume'] = quest:progressEvent(40),

            onEventFinish =
            {
                [40] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return xi.settings.main.ENABLE_MONSTROSITY == 1 and status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Suspicious_Elvaan'] = suspiciousCityNpc,

            onEventFinish =
            {
                [883] = tradeEventFinish,
            },
        },

        [xi.zone.PASHHOW_MARSHLANDS] =
        {
            ['Suspicious_Hume'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.keyItem.RING_OF_SUPERNAL_DISJUNCTION) then
                        return quest:priorityEvent(41)
                    else
                        return quest:priorityEvent(42)
                    end
                end,
            },
        },

        [xi.zone.PORT_BASTOK] =
        {
            ['Suspicious_Galka'] = suspiciousCityNpc,

            onEventFinish =
            {
                [419] = tradeEventFinish,
            },
        },

        [xi.zone.PORT_WINDURST] =
        {
            ['Suspicious_Tarutaru'] = suspiciousCityNpc,

            onEventFinish =
            {
                [881] = tradeEventFinish,
            },
        },

        [xi.zone.FERETORY] =
        {
            onZoneIn = function(player, prevZone)
                return 2
            end,

            onEventUpdate =
            {
                [2] = function(player, csid, option, npc)
                    if option == 1 then
                        xi.monstrosity.updateIntroEvent(player)
                    end
                end,
            },

            onEventFinish =
            {
                [2] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },
    },
}

return quest
