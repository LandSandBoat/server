-----------------------------------
-- Nyzul Isle: Treasure caskets and coffers methods and data.
-----------------------------------
local ID = zones[xi.zone.NYZUL_ISLE]
require('scripts/globals/appraisal')
-----------------------------------
xi = xi or {}
xi.nyzul = xi.nyzul or {}

local tempBoxItems =
{
    [ 1] = { itemID = xi.item.BOTTLE_OF_BARBARIANS_DRINK, amount = math.random(1, 3) },
    [ 2] = { itemID = xi.item.BOTTLE_OF_FIGHTERS_DRINK,   amount = math.random(1, 3) },
    [ 3] = { itemID = xi.item.BOTTLE_OF_ORACLES_DRINK,    amount = math.random(1, 3) },
    [ 4] = { itemID = xi.item.BOTTLE_OF_ASSASSINS_DRINK,  amount = math.random(1, 3) },
    [ 5] = { itemID = xi.item.BOTTLE_OF_SPYS_DRINK,       amount = math.random(1, 3) },
    [ 6] = { itemID = xi.item.BOTTLE_OF_BRAVERS_DRINK,    amount = math.random(1, 3) },
    [ 7] = { itemID = xi.item.BOTTLE_OF_SOLDIERS_DRINK,   amount = math.random(1, 3) },
    [ 8] = { itemID = xi.item.BOTTLE_OF_CHAMPIONS_DRINK,  amount = math.random(1, 3) },
    [ 9] = { itemID = xi.item.BOTTLE_OF_MONARCHS_DRINK,   amount = math.random(1, 3) },
    [10] = { itemID = xi.item.BOTTLE_OF_GNOSTICS_DRINK,   amount = math.random(1, 3) },
    [11] = { itemID = xi.item.BOTTLE_OF_CLERICS_DRINK,    amount = math.random(1, 3) },
    [12] = { itemID = xi.item.BOTTLE_OF_SHEPHERDS_DRINK,  amount = math.random(1, 3) },
    [13] = { itemID = xi.item.BOTTLE_OF_SPRINTERS_DRINK,  amount = math.random(1, 3) },
    [14] = { itemID = xi.item.FLASK_OF_STRANGE_MILK,      amount = math.random(1, 5) },
    [15] = { itemID = xi.item.BOTTLE_OF_STRANGE_JUICE,    amount = math.random(1, 5) },
    [16] = { itemID = xi.item.BOTTLE_OF_FANATICS_DRINK,   amount = 1                 },
    [17] = { itemID = xi.item.BOTTLE_OF_FOOLS_DRINK,      amount = 1                 },
    [18] = { itemID = xi.item.DUSTY_WING,                 amount = 1                 },
    [19] = { itemID = xi.item.BOTTLE_OF_VICARS_DRINK,     amount = math.random(1, 3) },
    [20] = { itemID = xi.item.DUSTY_POTION,               amount = math.random(1, 3) },
    [21] = { itemID = xi.item.DUSTY_ETHER,                amount = math.random(1, 3) },
    [22] = { itemID = xi.item.DUSTY_ELIXIR,               amount = 1                 }
}

local appraisalItems =
{
    [xi.appraisal.origin.NYZUL_BAT_EYE              ] = xi.item.UNAPPRAISED_AXE,
    [xi.appraisal.origin.NYZUL_SHADOW_EYE           ] = xi.item.UNAPPRAISED_NECKLACE,
    [xi.appraisal.origin.NYZUL_BOMB_KING            ] = xi.item.UNAPPRAISED_RING,
    [xi.appraisal.origin.NYZUL_JUGGLER_HECATOMB     ] = xi.item.UNAPPRAISED_POLEARM,
    [xi.appraisal.origin.NYZUL_SMOTHERING_SCHMIDT   ] = xi.item.UNAPPRAISED_RING,
    [xi.appraisal.origin.NYZUL_HELLION              ] = xi.item.UNAPPRAISED_POLEARM,
    [xi.appraisal.origin.NYZUL_LEAPING_LIZZY        ] = xi.item.UNAPPRAISED_FOOTWEAR,
    [xi.appraisal.origin.NYZUL_TOM_TIT_TAT          ] = xi.item.UNAPPRAISED_DAGGER,
    [xi.appraisal.origin.NYZUL_JAGGEDY_EARED_JACK   ] = xi.item.UNAPPRAISED_NECKLACE,
    [xi.appraisal.origin.NYZUL_CACTUAR_CANTAUTOR    ] = xi.item.UNAPPRAISED_FOOTWEAR,
    [xi.appraisal.origin.NYZUL_GARGANTUA            ] = xi.item.UNAPPRAISED_NECKLACE,
    [xi.appraisal.origin.NYZUL_GYRE_CARLIN          ] = xi.item.UNAPPRAISED_BOW,
    [xi.appraisal.origin.NYZUL_ASPHYXIATED_AMSEL    ] = xi.item.UNAPPRAISED_RING,
    [xi.appraisal.origin.NYZUL_FROSTMANE            ] = xi.item.UNAPPRAISED_SWORD,
    [xi.appraisal.origin.NYZUL_PEALLAIDH            ] = xi.item.UNAPPRAISED_GLOVES,
    [xi.appraisal.origin.NYZUL_CARNERO              ] = xi.item.UNAPPRAISED_SWORD,
    [xi.appraisal.origin.NYZUL_FALCATUS_ARANEI      ] = xi.item.UNAPPRAISED_POLEARM,
    [xi.appraisal.origin.NYZUL_EMERGENT_ELM         ] = xi.item.UNAPPRAISED_SWORD,
    [xi.appraisal.origin.NYZUL_OLD_TWO_WINGS        ] = xi.item.UNAPPRAISED_CAPE,
    [xi.appraisal.origin.NYZUL_AIATAR               ] = xi.item.UNAPPRAISED_BOX,
    [xi.appraisal.origin.NYZUL_INTULO               ] = xi.item.UNAPPRAISED_BOX,
    [xi.appraisal.origin.NYZUL_ORCTRAP              ] = xi.item.UNAPPRAISED_DAGGER,
    [xi.appraisal.origin.NYZUL_VALKURM_EMPEROR      ] = xi.item.UNAPPRAISED_HEADPIECE,
    [xi.appraisal.origin.NYZUL_CRUSHED_KRAUSE       ] = xi.item.UNAPPRAISED_RING,
    [xi.appraisal.origin.NYZUL_STINGING_SOPHIE      ] = xi.item.UNAPPRAISED_DAGGER,
    [xi.appraisal.origin.NYZUL_SERPOPARD_ISHTAR     ] = xi.item.UNAPPRAISED_NECKLACE,
    [xi.appraisal.origin.NYZUL_WESTERN_SHADOW       ] = xi.item.UNAPPRAISED_DAGGER,
    [xi.appraisal.origin.NYZUL_BLOODTEAR_BALDURF    ] = xi.item.UNAPPRAISED_SHIELD,
    [xi.appraisal.origin.NYZUL_ZIZZY_ZILLAH         ] = xi.item.UNAPPRAISED_SWORD,
    [xi.appraisal.origin.NYZUL_ELLYLLON             ] = xi.item.UNAPPRAISED_HEADPIECE,
    [xi.appraisal.origin.NYZUL_MISCHIEVOUS_MICHOLAS ] = xi.item.UNAPPRAISED_DAGGER,
    [xi.appraisal.origin.NYZUL_LEECH_KING           ] = xi.item.UNAPPRAISED_EARRING,
    [xi.appraisal.origin.NYZUL_EASTERN_SHADOW       ] = xi.item.UNAPPRAISED_BOW,
    [xi.appraisal.origin.NYZUL_NUNYENUNC            ] = xi.item.UNAPPRAISED_POLEARM,
    [xi.appraisal.origin.NYZUL_HELLDIVER            ] = xi.item.UNAPPRAISED_BOW,
    [xi.appraisal.origin.NYZUL_TAISAIJIN            ] = xi.item.UNAPPRAISED_HEADPIECE,
    [xi.appraisal.origin.NYZUL_FUNGUS_BEETLE        ] = xi.item.UNAPPRAISED_SHIELD,
    [xi.appraisal.origin.NYZUL_FRIAR_RUSH           ] = xi.item.UNAPPRAISED_BOX,
    [xi.appraisal.origin.NYZUL_PULVERIZED_PFEFFER   ] = xi.item.UNAPPRAISED_RING,
    [xi.appraisal.origin.NYZUL_ARGUS                ] = xi.item.UNAPPRAISED_NECKLACE,
    [xi.appraisal.origin.NYZUL_BLOODPOOL_VORAX      ] = xi.item.UNAPPRAISED_NECKLACE,
    [xi.appraisal.origin.NYZUL_NIGHTMARE_VASE       ] = xi.item.UNAPPRAISED_DAGGER,
    [xi.appraisal.origin.NYZUL_DAGGERCLAW_DRACOS    ] = xi.item.UNAPPRAISED_DAGGER,
    [xi.appraisal.origin.NYZUL_NORTHERN_SHADOW      ] = xi.item.UNAPPRAISED_AXE,
    [xi.appraisal.origin.NYZUL_FRAELISSA            ] = { xi.item.UNAPPRAISED_CAPE, xi.item.UNAPPRAISED_BOW },
    [xi.appraisal.origin.NYZUL_ROC                  ] = xi.item.UNAPPRAISED_POLEARM,
    [xi.appraisal.origin.NYZUL_SABOTENDER_BAILARIN  ] = xi.item.UNAPPRAISED_BOX,
    [xi.appraisal.origin.NYZUL_AQUARIUS             ] = xi.item.UNAPPRAISED_AXE,
    [xi.appraisal.origin.NYZUL_ENERGETIC_ERUCA      ] = xi.item.UNAPPRAISED_GLOVES,
    [xi.appraisal.origin.NYZUL_SPINY_SPIPI          ] = xi.item.UNAPPRAISED_CAPE,
    [xi.appraisal.origin.NYZUL_TRICKSTER_KINETIX    ] = xi.item.UNAPPRAISED_AXE,
    [xi.appraisal.origin.NYZUL_DROOLING_DAISY       ] = xi.item.UNAPPRAISED_HEADPIECE,
    [xi.appraisal.origin.NYZUL_BONNACON             ] = xi.item.UNAPPRAISED_FOOTWEAR,
    [xi.appraisal.origin.NYZUL_GOLDEN_BAT           ] = xi.item.UNAPPRAISED_CAPE,
    [xi.appraisal.origin.NYZUL_STEELFLEECE_BALDARICH] = xi.item.UNAPPRAISED_SHIELD,
    [xi.appraisal.origin.NYZUL_SABOTENDER_MARIACHI  ] = xi.item.UNAPPRAISED_DAGGER,
    [xi.appraisal.origin.NYZUL_UNGUR                ] = xi.item.UNAPPRAISED_BOW,
    [xi.appraisal.origin.NYZUL_SWAMFISK             ] = xi.item.UNAPPRAISED_POLEARM,
    [xi.appraisal.origin.NYZUL_BUBURIMBOO           ] = xi.item.UNAPPRAISED_NECKLACE,
    [xi.appraisal.origin.NYZUL_KEEPER_OF_HALIDOM    ] = xi.item.UNAPPRAISED_SWORD,
    [xi.appraisal.origin.NYZUL_SERKET               ] = xi.item.UNAPPRAISED_RING,
    [xi.appraisal.origin.NYZUL_DUNE_WIDOW           ] = xi.item.UNAPPRAISED_NECKLACE,
    [xi.appraisal.origin.NYZUL_ODQAN                ] = xi.item.UNAPPRAISED_BOX,
    [xi.appraisal.origin.NYZUL_BURNED_BERGMANN      ] = xi.item.UNAPPRAISED_RING,
    [xi.appraisal.origin.NYZUL_TYRANNIC_TUNNOK      ] = xi.item.UNAPPRAISED_AXE,
    [xi.appraisal.origin.NYZUL_BLOODSUCKER          ] = xi.item.UNAPPRAISED_RING,
    [xi.appraisal.origin.NYZUL_TOTTERING_TOBY       ] = xi.item.UNAPPRAISED_FOOTWEAR,
    [xi.appraisal.origin.NYZUL_SOUTHERN_SHADOW      ] = xi.item.UNAPPRAISED_SHIELD,
    [xi.appraisal.origin.NYZUL_SHARP_EARED_ROPIPI   ] = xi.item.UNAPPRAISED_HEADPIECE,
    [xi.appraisal.origin.NYZUL_PANZER_PERCIVAL      ] = xi.item.UNAPPRAISED_AXE,
    [xi.appraisal.origin.NYZUL_VOUIVRE              ] = xi.item.UNAPPRAISED_POLEARM,
    [xi.appraisal.origin.NYZUL_JOLLY_GREEN          ] = xi.item.UNAPPRAISED_SASH,
    [xi.appraisal.origin.NYZUL_TUMBLING_TRUFFLE     ] = xi.item.UNAPPRAISED_HEADPIECE,
    [xi.appraisal.origin.NYZUL_CAPRICIOUS_CASSIE    ] = xi.item.UNAPPRAISED_EARRING,
    [xi.appraisal.origin.NYZUL_AMIKIRI              ] = xi.item.UNAPPRAISED_SWORD,
    [xi.appraisal.origin.NYZUL_STRAY_MARY           ] = xi.item.UNAPPRAISED_BOX,
    [xi.appraisal.origin.NYZUL_SEWER_SYRUP          ] = xi.item.UNAPPRAISED_RING,
    [xi.appraisal.origin.NYZUL_UNUT                 ] = xi.item.UNAPPRAISED_BOX,
    [xi.appraisal.origin.NYZUL_SIMURGH              ] = xi.item.UNAPPRAISED_FOOTWEAR,
    [xi.appraisal.origin.NYZUL_PELICAN              ] = xi.item.UNAPPRAISED_SHIELD,
    [xi.appraisal.origin.NYZUL_CARGO_CRAB_COLIN     ] = xi.item.UNAPPRAISED_SWORD,
    [xi.appraisal.origin.NYZUL_WOUNDED_WURFEL       ] = xi.item.UNAPPRAISED_RING,
    [xi.appraisal.origin.NYZUL_PEG_POWLER           ] = xi.item.UNAPPRAISED_AXE,
    [xi.appraisal.origin.NYZUL_JADED_JODY           ] = xi.item.UNAPPRAISED_BOX,
    [xi.appraisal.origin.NYZUL_MAIGHDEAN_UAINE      ] = xi.item.UNAPPRAISED_EARRING,
}

xi.nyzul.tempBoxTrigger = function(player, npc)
    -- First interaction. Select items and open crate.
    if npc:getLocalVar('itemsPicked') == 0 then
        -- Build table.
        local dTableBoxItems = {}
        for i = 1, #tempBoxItems do
            table.insert(dTableBoxItems, i, tempBoxItems[i])
        end

        -- Execute rolls.
        local item2Random = math.random(1, 100)
        local item3Random = math.random(1, 100)

        -- Select items and amounts. Save selection into local vars.
        local entry = math.random(1, #dTableBoxItems)
        local item  = dTableBoxItems[entry]

        npc:setLocalVar('itemID_1', item.itemID)
        npc:setLocalVar('itemAmount_1', item.amount)
        table.remove(dTableBoxItems, entry)

        if item2Random <= 60 then
            entry = math.random(1, #dTableBoxItems)
            item  = dTableBoxItems[entry]

            npc:setLocalVar('itemID_2', item.itemID)
            npc:setLocalVar('itemAmount_2', item.amount)
            table.remove(tempBoxItems, entry)
        end

        if item2Random <= 60 and item3Random <= 20 then
            entry = math.random(1, #dTableBoxItems)
            item  = dTableBoxItems[entry]

            npc:setLocalVar('itemID_3', item.itemID)
            npc:setLocalVar('itemAmount_3', item.amount)
            table.remove(tempBoxItems, entry)
        end

        npc:entityAnimationPacket(xi.animationString.OPEN_CRATE_GLOW)
        npc:setAnimationSub(13)

        npc:setLocalVar('itemsPicked', 1)
    end

    player:startEvent(2, {
        [0] = (npc:getLocalVar('itemID_1') + (npc:getLocalVar('itemAmount_1') * 65536)),
        [1] = (npc:getLocalVar('itemID_2') + (npc:getLocalVar('itemAmount_2') * 65536)),
        [2] = (npc:getLocalVar('itemID_3') + (npc:getLocalVar('itemAmount_3') * 65536))
    })
end

xi.nyzul.handleAppraisalItem = function(player, npc)
    local instance = npc:getInstance()
    local chars    = instance:getChars()

    for cofferID = ID.npc.TREASURE_COFFER_OFFSET, ID.npc.TREASURE_COFFER_OFFSET + 2 do
        if npc:getID() == cofferID and npc:getLocalVar('opened') == 0 then
            -- Appraisal Items
            local mobOffset = npc:getLocalVar('appraisalItem') - (ID.mob.NM_OFFSET - xi.appraisal.origin.NYZUL_BAT_EYE) -- Bat Eye mobId - Appraisal mob value.

            if mobOffset == 166 or mobOffset == 187 then
                mobOffset = 108
            elseif mobOffset == 154 or mobOffset == 172 or mobOffset == 190 then
                mobOffset = 136
            end

            local itemID = appraisalItems[mobOffset]

            if type(itemID) == 'table' then
                local pick = math.random(1, #itemID)
                itemID     = itemID[pick]
            end

            if player:getFreeSlotsCount() == 0 then
                player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, itemID)

                return
            end

            player:addItem({ id = itemID, appraisal = mobOffset })

            for _, players in pairs(chars) do
                players:messageName(ID.text.PLAYER_OBTAINS_ITEM, player, itemID)
            end

            npc:entityAnimationPacket(xi.animationString.OPEN_CRATE_GLOW)
            npc:setLocalVar('opened', 1)
            npc:setUntargetable(true)
            npc:queue(10000, function(npcvar)
                npcvar:entityAnimationPacket(xi.animationString.STATUS_DISAPPEAR)
            end)

            npc:queue(12000, function(npcvar)
                npcvar:setStatus(xi.status.DISAPPEAR)
                npcvar:resetLocalVars()
                npcvar:setAnimationSub(0)
            end)

            break
        end
    end
end

xi.nyzul.tempBoxFinish = function(player, csid, option, npc)
    if csid == 2 then
        local item1 = npc:getLocalVar('itemID_1')
        local item2 = npc:getLocalVar('itemID_2')
        local item3 = npc:getLocalVar('itemID_3')

        if
            option == 1 and
            item1 > 0 and
            npc:getLocalVar('itemAmount_1') > 0
        then
            if not player:hasItem(item1, xi.inventoryLocation.TEMPITEMS) then
                player:addTempItem(item1)
                player:messageName(ID.text.PLAYER_OBTAINS_TEMP_ITEM, player, item1)
                npc:setLocalVar('itemAmount_1', npc:getLocalVar('itemAmount_1') - 1)
            else
                player:messageSpecial(ID.text.ALREADY_HAVE_TEMP_ITEM)
            end

        elseif
            option == 2 and
            item2 > 0 and
            npc:getLocalVar('itemAmount_2') > 0
        then
            if not player:hasItem(item2, xi.inventoryLocation.TEMPITEMS) then
                player:addTempItem(item2)
                player:messageName(ID.text.PLAYER_OBTAINS_TEMP_ITEM, player, item2)
                npc:setLocalVar('itemAmount_2', npc:getLocalVar('itemAmount_2') - 1)
            else
                player:messageSpecial(ID.text.ALREADY_HAVE_TEMP_ITEM)
            end

        elseif
            option == 3 and
            item3 > 0 and
            npc:getLocalVar('itemAmount_3') > 0
        then
            if not player:hasItem(item3, xi.inventoryLocation.TEMPITEMS) then
                player:addTempItem(item3)
                player:messageName(ID.text.PLAYER_OBTAINS_TEMP_ITEM, player, item3)
                npc:setLocalVar('itemAmount_3', npc:getLocalVar('itemAmount_3') - 1)
            else
                player:messageSpecial(ID.text.ALREADY_HAVE_TEMP_ITEM)
            end
        end

        if
            npc:getLocalVar('itemAmount_1') == 0 and
            npc:getLocalVar('itemAmount_2') == 0 and
            npc:getLocalVar('itemAmount_3') == 0
        then
            npc:queue(10000, function(npcvar)
                npcvar:entityAnimationPacket(xi.animationString.STATUS_DISAPPEAR)
            end)

            npc:queue(12000, function(npcvar)
                npcvar:setStatus(xi.status.DISAPPEAR)
                npcvar:setAnimationSub(0)
                npcvar:resetLocalVars()
            end)
        end
    end
end
