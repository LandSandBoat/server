-----------------------------------
-- Nyzul Isle: All treasure chest/casket logic.
-----------------------------------
local ID = zones[xi.zone.NYZUL_ISLE]
require('scripts/globals/appraisal')
-----------------------------------

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
    [xi.appraisal.origin.NYZUL_BAT_EYE              ] = xi.item.APPRAISAL_AXE,
    [xi.appraisal.origin.NYZUL_SHADOW_EYE           ] = xi.item.APPRAISAL_NECKLACE,
    [xi.appraisal.origin.NYZUL_BOMB_KING            ] = xi.item.APPRAISAL_RING,
    [xi.appraisal.origin.NYZUL_JUGGLER_HECATOMB     ] = xi.item.APPRAISAL_POLEARM,
    [xi.appraisal.origin.NYZUL_SMOTHERING_SCHMIDT   ] = xi.item.APPRAISAL_RING,
    [xi.appraisal.origin.NYZUL_HELLION              ] = xi.item.APPRAISAL_POLEARM,
    [xi.appraisal.origin.NYZUL_LEAPING_LIZZY        ] = xi.item.APPRAISAL_FOOTWEAR,
    [xi.appraisal.origin.NYZUL_TOM_TIT_TAT          ] = xi.item.APPRAISAL_DAGGER,
    [xi.appraisal.origin.NYZUL_JAGGEDY_EARED_JACK   ] = xi.item.APPRAISAL_NECKLACE,
    [xi.appraisal.origin.NYZUL_CACTUAR_CANTAUTOR    ] = xi.item.APPRAISAL_FOOTWEAR,
    [xi.appraisal.origin.NYZUL_GARGANTUA            ] = xi.item.APPRAISAL_NECKLACE,
    [xi.appraisal.origin.NYZUL_GYRE_CARLIN          ] = xi.item.APPRAISAL_BOW,
    [xi.appraisal.origin.NYZUL_ASPHYXIATED_AMSEL    ] = xi.item.APPRAISAL_RING,
    [xi.appraisal.origin.NYZUL_FROSTMANE            ] = xi.item.APPRAISAL_SWORD,
    [xi.appraisal.origin.NYZUL_PEALLAIDH            ] = xi.item.APPRAISAL_GLOVES,
    [xi.appraisal.origin.NYZUL_CARNERO              ] = xi.item.APPRAISAL_SWORD,
    [xi.appraisal.origin.NYZUL_FALCATUS_ARANEI      ] = xi.item.APPRAISAL_POLEARM,
    [xi.appraisal.origin.NYZUL_EMERGENT_ELM         ] = xi.item.APPRAISAL_SWORD,
    [xi.appraisal.origin.NYZUL_OLD_TWO_WINGS        ] = xi.item.APPRAISAL_CAPE,
    [xi.appraisal.origin.NYZUL_AIATAR               ] = xi.item.APPRAISAL_BOX,
    [xi.appraisal.origin.NYZUL_INTULO               ] = xi.item.APPRAISAL_BOX,
    [xi.appraisal.origin.NYZUL_ORCTRAP              ] = xi.item.APPRAISAL_DAGGER,
    [xi.appraisal.origin.NYZUL_VALKURM_EMPEROR      ] = xi.item.APPRAISAL_HEADPIECE,
    [xi.appraisal.origin.NYZUL_CRUSHED_KRAUSE       ] = xi.item.APPRAISAL_RING,
    [xi.appraisal.origin.NYZUL_STINGING_SOPHIE      ] = xi.item.APPRAISAL_DAGGER,
    [xi.appraisal.origin.NYZUL_SERPOPARD_ISHTAR     ] = xi.item.APPRAISAL_NECKLACE,
    [xi.appraisal.origin.NYZUL_WESTERN_SHADOW       ] = xi.item.APPRAISAL_DAGGER,
    [xi.appraisal.origin.NYZUL_BLOODTEAR_BALDURF    ] = xi.item.APPRAISAL_SHIELD,
    [xi.appraisal.origin.NYZUL_ZIZZY_ZILLAH         ] = xi.item.APPRAISAL_SWORD,
    [xi.appraisal.origin.NYZUL_ELLYLLON             ] = xi.item.APPRAISAL_HEADPIECE,
    [xi.appraisal.origin.NYZUL_MISCHIEVOUS_MICHOLAS ] = xi.item.APPRAISAL_DAGGER,
    [xi.appraisal.origin.NYZUL_LEECH_KING           ] = xi.item.APPRAISAL_EARRING,
    [xi.appraisal.origin.NYZUL_EASTERN_SHADOW       ] = xi.item.APPRAISAL_BOW,
    [xi.appraisal.origin.NYZUL_NUNYENUNC            ] = xi.item.APPRAISAL_POLEARM,
    [xi.appraisal.origin.NYZUL_HELLDIVER            ] = xi.item.APPRAISAL_BOW,
    [xi.appraisal.origin.NYZUL_TAISAIJIN            ] = xi.item.APPRAISAL_HEADPIECE,
    [xi.appraisal.origin.NYZUL_FUNGUS_BEETLE        ] = xi.item.APPRAISAL_SHIELD,
    [xi.appraisal.origin.NYZUL_FRIAR_RUSH           ] = xi.item.APPRAISAL_BOX,
    [xi.appraisal.origin.NYZUL_PULVERIZED_PFEFFER   ] = xi.item.APPRAISAL_RING,
    [xi.appraisal.origin.NYZUL_ARGUS                ] = xi.item.APPRAISAL_NECKLACE,
    [xi.appraisal.origin.NYZUL_BLOODPOOL_VORAX      ] = xi.item.APPRAISAL_NECKLACE,
    [xi.appraisal.origin.NYZUL_NIGHTMARE_VASE       ] = xi.item.APPRAISAL_DAGGER,
    [xi.appraisal.origin.NYZUL_DAGGERCLAW_DRACOS    ] = xi.item.APPRAISAL_DAGGER,
    [xi.appraisal.origin.NYZUL_NORTHERN_SHADOW      ] = xi.item.APPRAISAL_AXE,
    [xi.appraisal.origin.NYZUL_FRAELISSA            ] = { xi.item.APPRAISAL_CAPE, xi.item.APPRAISAL_BOW },
    [xi.appraisal.origin.NYZUL_ROC                  ] = xi.item.APPRAISAL_POLEARM,
    [xi.appraisal.origin.NYZUL_SABOTENDER_BAILARIN  ] = xi.item.APPRAISAL_BOX,
    [xi.appraisal.origin.NYZUL_AQUARIUS             ] = xi.item.APPRAISAL_AXE,
    [xi.appraisal.origin.NYZUL_ENERGETIC_ERUCA      ] = xi.item.APPRAISAL_GLOVES,
    [xi.appraisal.origin.NYZUL_SPINY_SPIPI          ] = xi.item.APPRAISAL_CAPE,
    [xi.appraisal.origin.NYZUL_TRICKSTER_KINETIX    ] = xi.item.APPRAISAL_AXE,
    [xi.appraisal.origin.NYZUL_DROOLING_DAISY       ] = xi.item.APPRAISAL_HEADPIECE,
    [xi.appraisal.origin.NYZUL_BONNACON             ] = xi.item.APPRAISAL_FOOTWEAR,
    [xi.appraisal.origin.NYZUL_GOLDEN_BAT           ] = xi.item.APPRAISAL_CAPE,
    [xi.appraisal.origin.NYZUL_STEELFLEECE_BALDARICH] = xi.item.APPRAISAL_SHIELD,
    [xi.appraisal.origin.NYZUL_SABOTENDER_MARIACHI  ] = xi.item.APPRAISAL_DAGGER,
    [xi.appraisal.origin.NYZUL_UNGUR                ] = xi.item.APPRAISAL_BOW,
    [xi.appraisal.origin.NYZUL_SWAMFISK             ] = xi.item.APPRAISAL_POLEARM,
    [xi.appraisal.origin.NYZUL_BUBURIMBOO           ] = xi.item.APPRAISAL_NECKLACE,
    [xi.appraisal.origin.NYZUL_KEEPER_OF_HALIDOM    ] = xi.item.APPRAISAL_SWORD,
    [xi.appraisal.origin.NYZUL_SERKET               ] = xi.item.APPRAISAL_RING,
    [xi.appraisal.origin.NYZUL_DUNE_WIDOW           ] = xi.item.APPRAISAL_NECKLACE,
    [xi.appraisal.origin.NYZUL_ODQAN                ] = xi.item.APPRAISAL_BOX,
    [xi.appraisal.origin.NYZUL_BURNED_BERGMANN      ] = xi.item.APPRAISAL_RING,
    [xi.appraisal.origin.NYZUL_TYRANNIC_TUNNOK      ] = xi.item.APPRAISAL_AXE,
    [xi.appraisal.origin.NYZUL_BLOODSUCKER          ] = xi.item.APPRAISAL_RING,
    [xi.appraisal.origin.NYZUL_TOTTERING_TOBY       ] = xi.item.APPRAISAL_FOOTWEAR,
    [xi.appraisal.origin.NYZUL_SOUTHERN_SHADOW      ] = xi.item.APPRAISAL_SHIELD,
    [xi.appraisal.origin.NYZUL_SHARP_EARED_ROPIPI   ] = xi.item.APPRAISAL_HEADPIECE,
    [xi.appraisal.origin.NYZUL_PANZER_PERCIVAL      ] = xi.item.APPRAISAL_AXE,
    [xi.appraisal.origin.NYZUL_VOUIVRE              ] = xi.item.APPRAISAL_POLEARM,
    [xi.appraisal.origin.NYZUL_JOLLY_GREEN          ] = xi.item.APPRAISAL_SASH,
    [xi.appraisal.origin.NYZUL_TUMBLING_TRUFFLE     ] = xi.item.APPRAISAL_HEADPIECE,
    [xi.appraisal.origin.NYZUL_CAPRICIOUS_CASSIE    ] = xi.item.APPRAISAL_EARRING,
    [xi.appraisal.origin.NYZUL_AMIKIRI              ] = xi.item.APPRAISAL_SWORD,
    [xi.appraisal.origin.NYZUL_STRAY_MARY           ] = xi.item.APPRAISAL_BOX,
    [xi.appraisal.origin.NYZUL_SEWER_SYRUP          ] = xi.item.APPRAISAL_RING,
    [xi.appraisal.origin.NYZUL_UNUT                 ] = xi.item.APPRAISAL_BOX,
    [xi.appraisal.origin.NYZUL_SIMURGH              ] = xi.item.APPRAISAL_FOOTWEAR,
    [xi.appraisal.origin.NYZUL_PELICAN              ] = xi.item.APPRAISAL_SHIELD,
    [xi.appraisal.origin.NYZUL_CARGO_CRAB_COLIN     ] = xi.item.APPRAISAL_SWORD,
    [xi.appraisal.origin.NYZUL_WOUNDED_WURFEL       ] = xi.item.APPRAISAL_RING,
    [xi.appraisal.origin.NYZUL_PEG_POWLER           ] = xi.item.APPRAISAL_AXE,
    [xi.appraisal.origin.NYZUL_JADED_JODY           ] = xi.item.APPRAISAL_BOX,
    [xi.appraisal.origin.NYZUL_MAIGHDEAN_UAINE      ] = xi.item.APPRAISAL_EARRING,
}

xi.nyzul.baseWeapons =
{
    [xi.job.WAR] = xi.item.STURDY_AXE,
    [xi.job.MNK] = xi.item.BURNING_FISTS,
    [xi.job.WHM] = xi.item.WEREBUSTER,
    [xi.job.BLM] = xi.item.MAGES_STAFF,
    [xi.job.RDM] = xi.item.VORPAL_SWORD,
    [xi.job.THF] = xi.item.SWORDBREAKER,
    [xi.job.PLD] = xi.item.BRAVE_BLADE,
    [xi.job.DRK] = xi.item.DEATH_SICKLE,
    [xi.job.BST] = xi.item.DOUBLE_AXE,
    [xi.job.BRD] = xi.item.DANCING_DAGGER,
    [xi.job.RNG] = xi.item.KILLER_BOW,
    [xi.job.SAM] = xi.item.WINDSLICER,
    [xi.job.NIN] = xi.item.SASUKE_KATANA,
    [xi.job.DRG] = xi.item.RADIANT_LANCE,
    [xi.job.SMN] = xi.item.SCEPTER_STAFF,
    [xi.job.BLU] = xi.item.WIGHTSLAYER,
    [xi.job.COR] = xi.item.QUICKSILVER,
    [xi.job.PUP] = xi.item.INFERNO_CLAWS,
    [xi.job.DNC] = xi.item.MAIN_GAUCHE,
    [xi.job.SCH] = xi.item.ELDER_STAFF,
}

-----------------------------------
-- Armoury_Crate NPC functions.
-----------------------------------
-- Trigger function. Hands over an apraisal item directly to the player.
xi.nyzul.handleAppraisalItem = function(player, npc)
    local instance = npc:getInstance()
    local chars    = instance:getChars()

    for _, cofferID in ipairs(ID.npc.TREASURE_COFFER) do
        if
            npc:getID() == cofferID and
            npc:getLocalVar('opened') == 0
        then
            -- Appraisal Item selection. Based on mob killed.
            local mobOffset = npc:getLocalVar('appraisalItem') - (ID.mob[51].OFFSET_NM - xi.appraisal.origin.NYZUL_BAT_EYE) -- Bat Eye mobId - Appraisal mob value.

            if mobOffset == 166 or mobOffset == 187 then
                mobOffset = 108
            elseif mobOffset == 154 or mobOffset == 172 or mobOffset == 190 then
                mobOffset = 136
            end

            local itemID = appraisalItems[mobOffset]

            if type(itemID) == "table" then
                local pick = math.random(1, #itemID)
                itemID     = itemID[pick]
            end

            -- Inventory check.
            if player:getFreeSlotsCount() == 0 then
                player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, itemID)

                return
            end

            -- Item giveaway.
            player:addItem({ id = itemID, appraisal = mobOffset })

            for _, players in pairs(chars) do
                players:messageName(ID.text.PLAYER_OBTAINS_ITEM, player, itemID)
            end

            -- Open chest animation.
            npc:entityAnimationPacket('open')
            npc:setLocalVar('opened', 1)
            npc:setUntargetable(true)
            npc:queue(10000, function(npcvar)
                npcvar:entityAnimationPacket('kesu')
            end)

            -- Despawn chest.
            npc:queue(12000, function(npcvar)
                npcvar:setStatus(xi.status.DISAPPEAR)
                npcvar:resetLocalVars()
                npcvar:setAnimationSub(0)
            end)

            break
        end
    end
end

-- Trigger function. Very similar to regular caskets.
xi.nyzul.tempBoxTrigger = function(player, npc)
    -- TODO: shouldn't we be building a dynamic table instead of removing from the global table directly?
    -- This may not be the case though. Ask KO, you fool.

    -- Choose 1 to 3 items and amounts.
    if npc:getLocalVar('itemsPicked') == 0 then
        npc:setLocalVar('itemsPicked', 1)
        npc:entityAnimationPacket('open')
        npc:setAnimationSub(13)

        -- First (mandatory) item selection.
        local itemIndex = math.random(1, #tempBoxItems)
        local itemData  = tempBoxItems[itemIndex]

        if npc:getLocalVar('itemID_1') == 0 then
            npc:setLocalVar('itemID_1', itemData.itemID)
            npc:setLocalVar('itemAmount_1', itemData.amount)
            table.remove(tempBoxItems, itemIndex)
        end

        -- Second item selection.
        local item2Random = math.random(1, 10)

        if item2Random >= 5 then
            itemIndex = math.random(1, #tempBoxItems)
            itemData  = tempBoxItems[itemIndex]

            npc:setLocalVar('itemID_2', itemData.itemID)
            npc:setLocalVar('itemAmount_2', itemData.amount)
            table.remove(tempBoxItems, itemIndex)
        end

        -- Third item selection.
        local item3Random = math.random(1, 10)

        if item2Random >= 5 and item3Random >= 9 then
            itemIndex = math.random(1, #tempBoxItems)
            itemData  = tempBoxItems[itemIndex]

            npc:setLocalVar('itemID_3', itemData.itemID)
            npc:setLocalVar('itemAmount_3', itemData.amount)
            table.remove(tempBoxItems, itemIndex)
        end
    end

    -- Start the event (2) converting the pre-calculated values to event arguments.
    player:startEvent(2, {
        [0] = (npc:getLocalVar('itemID_1') + (npc:getLocalVar('itemAmount_1') * 65536)),
        [1] = (npc:getLocalVar('itemID_2') + (npc:getLocalVar('itemAmount_2') * 65536)),
        [2] = (npc:getLocalVar('itemID_3') + (npc:getLocalVar('itemAmount_3') * 65536))
    })
end

-- onEventFinish function. Handles item selection and npc despawn.
xi.nyzul.tempBoxFinish = function(player, csid, option, npc)
    if csid == 2 then
        local item1 = npc:getLocalVar('itemID_1')
        local item2 = npc:getLocalVar('itemID_2')
        local item3 = npc:getLocalVar('itemID_3')

        -- If box is not empty.
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

        -- If box is empty, despawn it.
        if
            npc:getLocalVar('itemAmount_1') == 0 and
            npc:getLocalVar('itemAmount_2') == 0 and
            npc:getLocalVar('itemAmount_3') == 0
        then
            npc:queue(10000, function(npcvar)
                npcvar:entityAnimationPacket('kesu')
            end)

            npc:queue(12000, function(npcvar)
                npcvar:setStatus(xi.status.DISAPPEAR)
                npcvar:setAnimationSub(0)
                npcvar:resetLocalVars()
            end)
        end
    end
end

-----------------------------------
-- Mob and floor cleanup functions.
-----------------------------------
-- Used in boss mob scripts (directly) and in every NM script (indirectly) via 'spawnChest' function.
xi.nyzul.vigilWeaponDrop = function(player, mob)
    local instance = mob:getInstance()

    -- Only floor 100 Bosses to drop 1 random weapon guarenteed and 1 of the disk holders job
    -- will not drop diskholder's weapon if anyone already has it.
    if instance:getLocalVar('[Nyzul]CurrentFloor') == 100 then
        local diskHolder = GetPlayerByID(instance:getLocalVar('diskHolder'), instance)
        local chars      = instance:getChars()

        if diskHolder ~= nil then
            for _, entity in pairs(chars) do
                if not entity:hasItem(xi.nyzul.baseWeapons[diskHolder:getMainJob()]) then
                    player:addTreasure(xi.nyzul.baseWeapons[diskHolder:getMainJob()], mob)

                    break
                end
            end
        end

        player:addTreasure(xi.nyzul.baseWeapons[math.random(1, #xi.nyzul.baseWeapons)], mob)

    -- Every NM can randomly drop a vigil weapon
    elseif math.random(1, 100) <= 20 and xi.settings.main.ENABLE_VIGIL_DROPS then
        player:addTreasure(xi.nyzul.baseWeapons[math.random(1, #xi.nyzul.baseWeapons)], mob)
    end
end

-- Used in NM mob scripts, except the floor X0 bosses.
xi.nyzul.spawnChest = function(mob, player)
    local instance = mob:getInstance()
    local mobID    = mob:getID()

    -- NM coffer spawn. TODO: Since this are called from mob scripts directly, this mob ID checks are probably unnecesary.
    if
        mobID >= ID.mob[51].OFFSET_NM and
        mobID <= ID.mob[51].TAISAIJIN
    then
        xi.nyzul.vigilWeaponDrop(player, mob)

        for _, cofferID in ipairs(ID.npc.TREASURE_COFFER) do
            local coffer = GetNPCByID(cofferID, instance)

            if coffer:getStatus() == xi.status.DISAPPEAR then
                local pos = mob:getPos()
                coffer:setUntargetable(false)
                coffer:setPos(pos.x, pos.y, pos.z, pos.rot)
                coffer:setLocalVar('appraisalItem', mobID)
                coffer:setStatus(xi.status.NORMAL)

                break
            end
        end

    -- NM casket spawn. TODO: Since this are called from mob scripts directly, this mob ID checks are probably unnecesary.
    elseif
        mobID < ID.mob[51].ADAMANTOISE and
        xi.settings.main.ENABLE_NYZUL_CASKETS
    then
        if math.random(1, 100) <= 5 then
            for _, casketID in ipairs(ID.npc.TREASURE_CASKET) do
                local casket = GetNPCByID(casketID, instance)

                if casket:getStatus() == xi.status.DISAPPEAR then
                    local pos = mob:getPos()
                    casket:setPos(pos.x, pos.y, pos.z, pos.rot)
                    casket:setStatus(xi.status.NORMAL)

                    break
                end
            end
        end
    end
end

-- Used in rune of transfer (floor cleanup)
xi.nyzul.clearChests = function(instance)
    -- Despawn coffers.
    for _, cofferID in ipairs(ID.npc.TREASURE_COFFER) do
        local coffer = GetNPCByID(cofferID, instance)

        if coffer:getStatus() ~= xi.status.DISAPPEAR then
            coffer:setStatus(xi.status.DISAPPEAR)
            coffer:setAnimationSub(0)
            coffer:resetLocalVars()
        end
    end

    -- Despawn caskets.
    for _, casketID in ipairs(ID.npc.TREASURE_CASKET) do
        local casket = GetNPCByID(casketID, instance)

        if casket:getStatus() ~= xi.status.DISAPPEAR then
            casket:setStatus(xi.status.DISAPPEAR)
            casket:setAnimationSub(0)
            casket:resetLocalVars()
        end
    end
end
