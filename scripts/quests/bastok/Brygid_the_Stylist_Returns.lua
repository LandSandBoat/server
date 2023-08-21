-----------------------------------
-- Brygid the Stylist Returns
-----------------------------------
-- Log ID: 1, Quest ID: 74
-- Brygid : !pos -90 -4 -108 235
-----------------------------------

local quest = Quest:new(xi.quest.log_id.BASTOK, xi.quest.id.bastok.BRYGID_THE_STYLIST_RETURNS)

quest.reward =
{
    fame     = 30,
    fameArea = xi.quest.fame_area.BASTOK,
    title    = xi.title.BASTOKS_SECOND_BEST_DRESSED,
}

local requestedBodyItems =
{
    xi.item.BREASTPLATE,
    xi.item.SILVER_MAIL,
    xi.item.BANDED_MAIL,
    xi.item.CUIR_BOUILLI,
    xi.item.RAPTOR_JERKIN,
    xi.item.PADDED_ARMOR,
    xi.item.GAMBISON,
    xi.item.WOOL_GAMBISON,
    xi.item.VELVET_ROBE,
    xi.item.SILK_COAT,
    xi.item.CLOAK,
    xi.item.WHITE_CLOAK,
    xi.item.BEAK_JERKIN,
    xi.item.CARAPACE_HARNESS,
    xi.item.PYRO_ROBE,
    xi.item.FROST_ROBE,
    xi.item.LINEN_DOUBLET,
    xi.item.WOOL_DOUBLET,
    xi.item.IRON_SCALE_MAIL,
    xi.item.BISHOPS_ROBE,
}

local requestedLegItems =
{
    xi.item.CUISSES,
    xi.item.SILVER_HOSE,
    xi.item.BREECHES,
    xi.item.CUIR_TROUSERS,
    xi.item.RAPTOR_TROUSERS,
    xi.item.BEAK_TROUSERS,
    xi.item.IRON_SUBLIGAR,
    xi.item.CARAPACE_SUBLIGAR,
    xi.item.SCORPION_SUBLIGAR,
    xi.item.HOSE,
    xi.item.WOOL_HOSE,
    xi.item.VELVET_SLOPS,
    xi.item.SILK_SLOPS,
    xi.item.LINEN_SLACKS,
    xi.item.WHITE_SLACKS,
    xi.item.IRON_CUISSES,
}

-- [option] = { rewardItem, requiredItem }
local optionToItems =
{
    [ 1] = { xi.item.DUENDE_COTEHARDIE,   xi.item.ARIES_SUBLIGAR       },
    [ 2] = { xi.item.NOKIZARU_GI,         xi.item.TAURUS_SUBLIGAR      },
    [ 3] = { xi.item.RAPPAREE_HARNESS,    xi.item.GEMINI_SUBLIGAR      },
    [ 4] = { xi.item.SHINIMUSHA_HARA_ATE, xi.item.CANCER_SUBLIGAR      },
    [ 5] = { xi.item.WYVERN_MAIL,         xi.item.LEO_SUBLIGAR         },
    [ 6] = { xi.item.SHIKAREE_AKETON,     xi.item.VIRGO_SUBLIGAR       },
    [ 7] = { xi.item.CERISE_DOUBLET,      xi.item.LIBRA_SUBLIGAR       },
    [ 8] = { xi.item.GLAMOR_JUPON,        xi.item.SCORPIUS_SUBLIGAR    },
    [ 9] = { xi.item.GLOOM_BREASTPLATE,   xi.item.SAGITTARIUS_SUBLIGAR },
    [10] = { xi.item.NIMBUS_DOUBLET,      xi.item.CAPRICORNUS_SUBLIGAR },
    [11] = { xi.item.AIKIDO_GI,           xi.item.AQUARIUS_SUBLIGAR    },
    [12] = { xi.item.PARADE_CUIRASS,      xi.item.PISCES_SUBLIGAR      },
    [13] = { xi.item.GAUDY_HARNESS,       xi.item.OPHIUCHUS_SUBLIGAR   },
}

local getRandomEquippableItem = function(player, itemList)
    -- To not repeatedly select a random number and compare, first generate a list
    -- of known items that can be equipped.
    local equippableItems = {}

    for _, itemId in ipairs(itemList) do
        if player:canEquipItem(itemId, false) then
            table.insert(equippableItems, itemId)
        end
    end

    return equippableItems[math.random(1, #equippableItems)]
end

local hasArtifactArmorEquipped = function(player)
    for equipSlot = xi.slot.HEAD, xi.slot.FEET do
        if xi.equip.isArtifactArmor(player:getEquipID(equipSlot)) then
            return true
        end
    end

    return false
end

quest.sections =
{
    {
        check = function(player, status, vars)
            return status ~= QUEST_ACCEPTED and
                player:hasCompletedQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.BRYGID_THE_STYLIST) and
                hasArtifactArmorEquipped(player)
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Brygid'] =
            {
                onTrigger = function(player, npc)
                    local hasRobeEquipped = player:getEquipID(xi.slot.BODY) == xi.item.ROBE and 1 or 0
                    local requestedBody   = getRandomEquippableItem(player, requestedBodyItems)
                    local requestedLegs   = getRandomEquippableItem(player, requestedLegItems)

                    quest:setVar(player, 'requestedBody', requestedBody)
                    quest:setVar(player, 'requestedLegs', requestedLegs)

                    return quest:progressEvent(380, hasRobeEquipped, requestedBody, requestedLegs, player:getMainJob())
                end,
            },

            onEventFinish =
            {
                [380] = function(player, csid, option, npc)
                    player:delQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.BRYGID_THE_STYLIST_RETURNS)
                    quest:begin(player)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Brygid'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, optionToItems[quest:getVar(player, 'Option')][2]) then
                        return quest:progressEvent(383)
                    end
                end,

                onTrigger = function(player, npc)
                    local questOption = quest:getVar(player, 'Option')

                    if questOption == 0 then
                        if
                            player:getEquipID(xi.slot.BODY) == quest:getVar(player, 'requestedBody') and
                            player:getEquipID(xi.slot.LEGS) == quest:getVar(player, 'requestedLegs')
                        then
                            return quest:progressEvent(382)
                        else
                            local hasRobeEquipped = player:getEquipID(xi.slot.BODY) == xi.item.ROBE and 1 or 0
                            local requestedBody   = quest:getVar(player, 'requestedBody')
                            local requestedLegs   = quest:getVar(player, 'requestedLegs')

                            return quest:event(381, hasRobeEquipped, requestedBody, requestedLegs, player:getMainJob())
                        end
                    else
                        local optionList = optionToItems[questOption]

                        return quest:event(385, 0, optionList[1], optionList[2])
                    end
                end,
            },

            onEventUpdate =
            {
                [382] = function(player, csid, option, npc)
                    local rewardItem     = xi.item.DUENDE_COTEHARDIE - 1 + option
                    local canEquipReward = player:canEquipItem(rewardItem, true) and 1 or 0
                    local hasReward      = not player:hasItem(rewardItem) and 1 or 0

                    player:updateEvent(0, option - 1, hasReward, canEquipReward)
                end,
            },

            onEventFinish =
            {
                [382] = function(player, csid, option, npc)
                    if option ~= 99 then
                        quest:setVar(player, 'Option', option)
                    end
                end,

                [383] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, optionToItems[quest:getVar(player, 'Option')][1]) then
                        quest:complete(player)
                    end
                end,
            },
        },
    },
}

return quest
