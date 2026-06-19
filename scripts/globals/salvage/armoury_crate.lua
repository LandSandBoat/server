-----------------------------------
-- Salvage: Armory Crate and Temp Chest methods.
-----------------------------------
xi = xi or {}
xi.salvage = xi.salvage or {}

local tempBoxItems =
{
    [ 1] = { itemID = xi.item.HI_POTION,                      amount = math.random(3)  },
    [ 2] = { itemID = xi.item.REVITALIZER,                    amount = 1               },
    [ 3] = { itemID = xi.item.BOTTLE_OF_BODY_BOOST,           amount = 1               },
    [ 4] = { itemID = xi.item.BOTTLE_OF_MANA_BOOST,           amount = 1               },
    [ 5] = { itemID = xi.item.MEGALIXIR,                      amount = 1               },
    [ 6] = { itemID = xi.item.PINCH_OF_MANA_POWDER,           amount = 1               },
    [ 7] = { itemID = xi.item.BOTTLE_OF_GIANTS_DRINK,         amount = 1               },
    [ 8] = { itemID = xi.item.BOTTLE_OF_WIZARDS_DRINK,        amount = 1               },
    [ 9] = { itemID = xi.item.HERMES_QUENCHER,                amount = 1               },
    [10] = { itemID = xi.item.FLASK_OF_HEALING_POWDER,        amount = 1               },
    [11] = { itemID = xi.item.BOTTLE_OF_BARBARIANS_DRINK,     amount = math.random(3)  },
    [12] = { itemID = xi.item.BOTTLE_OF_FIGHTERS_DRINK,       amount = math.random(3)  },
    [13] = { itemID = xi.item.BOTTLE_OF_ORACLES_DRINK,        amount = math.random(3)  },
    [14] = { itemID = xi.item.BOTTLE_OF_ASSASSINS_DRINK,      amount = math.random(3)  },
    [15] = { itemID = xi.item.BOTTLE_OF_SPYS_DRINK,           amount = math.random(3)  },
    [16] = { itemID = xi.item.BOTTLE_OF_BRAVERS_DRINK,        amount = math.random(3)  },
    [17] = { itemID = xi.item.BOTTLE_OF_SOLDIERS_DRINK,       amount = math.random(3)  },
    [18] = { itemID = xi.item.BOTTLE_OF_CHAMPIONS_DRINK,      amount = math.random(3)  },
    [19] = { itemID = xi.item.BOTTLE_OF_MONARCHS_DRINK,       amount = math.random(3)  },
    [20] = { itemID = xi.item.BOTTLE_OF_GNOSTICS_DRINK,       amount = math.random(3)  },
    [21] = { itemID = xi.item.BOTTLE_OF_CLERICS_DRINK,        amount = math.random(3)  },
    [22] = { itemID = xi.item.BOTTLE_OF_SHEPHERDS_DRINK,      amount = math.random(3)  },
    [23] = { itemID = xi.item.BOTTLE_OF_SPRINTERS_DRINK,      amount = math.random(3)  },
    [24] = { itemID = xi.item.DUSTY_POTION,                   amount = math.random(10) },
    [25] = { itemID = xi.item.DUSTY_ETHER,                    amount = math.random(10) },
    [26] = { itemID = xi.item.DUSTY_ELIXIR,                   amount = 1               },
    [27] = { itemID = xi.item.BOTTLE_OF_FANATICS_DRINK,       amount = 1               },
    [28] = { itemID = xi.item.BOTTLE_OF_FOOLS_DRINK,          amount = 1               },
    [29] = { itemID = xi.item.DUSTY_SCROLL_OF_RERAISE,        amount = math.random(3)  },
    [30] = { itemID = xi.item.FLASK_OF_STRANGE_MILK,          amount = math.random(5)  },
    [31] = { itemID = xi.item.BOTTLE_OF_STRANGE_JUICE,        amount = math.random(5)  },
    [32] = { itemID = xi.item.BOTTLE_OF_VICARS_DRINK,         amount = math.random(3)  },
    [33] = { itemID = xi.item.DUSTY_WING,                     amount = 1               },
}

xi.salvage.onTriggerCrate = function(player, npc)
    if npc:getLocalVar('open') == 0 then
        npc:setLocalVar('open', 1)

        local firstRandom =
        {
            xi.item.CUMULUS_CELL,
            xi.item.UNDULATUS_CELL,
            xi.item.HUMILUS_CELL,
            xi.item.SPISSATUS_CELL,
        }

        local secondRandom =
        {
            xi.item.CASTELLANUS_CELL,
            xi.item.RADIATUS_CELL,
            xi.item.STRATUS_CELL,
            xi.item.CIRROCUMULUS_CELL,
            xi.item.VIRGA_CELL,
            xi.item.PANNUS_CELL,
            xi.item.FRACTUS_CELL,
            xi.item.CONGESTUS_CELL,
            xi.item.NIMBUS_CELL,
            xi.item.VELUM_CELL,
            xi.item.PILEUS_CELL,
            xi.item.MEDIOCRIS_CELL,
        }

        player:addTreasure(xi.item.INCUS_CELL, npc)
        player:addTreasure(xi.item.INCUS_CELL, npc)
        player:addTreasure(xi.item.DUPLICATUS_CELL, npc)
        player:addTreasure(xi.item.PRAECIPITATIO_CELL, npc)
        player:addTreasure(xi.item.OPACUS_CELL, npc)
        player:addTreasure(firstRandom[math.random(#firstRandom)], npc)
        player:addTreasure(firstRandom[math.random(#firstRandom)], npc)
        player:addTreasure(secondRandom[math.random(#secondRandom)], npc)
        player:addTreasure(secondRandom[math.random(#secondRandom)], npc)

        if math.random(1, 2) == 1 then
            player:addTreasure(xi.item.PRAECIPITATIO_CELL, npc)
        else
            player:addTreasure(xi.item.OPACUS_CELL, npc)
        end

        npc:entityAnimationPacket(xi.animationString.OPEN_CRATE_GLOW)

        npc:timer(15000, function(npcArg)
            npcArg:entityAnimationPacket(xi.animationString.STATUS_DISAPPEAR)
        end)

        npc:timer(16000, function(npcArg)
            npcArg:setStatus(xi.status.DISAPPEAR)
        end)
    end
end

xi.salvage.spawnTempChest = function(mob, params, isForceSpawn)
    local ID       = zones[mob:getZoneID()]
    local instance = mob:getInstance()

    if
        isForceSpawn or
        math.random(100) <= xi.settings.main.SALVAGE_TEMP_CHEST_RATE
    then
        for _, casketID in ipairs(ID.npc[0].TEMP_ITEMS_BOX) do
            local casket = GetNPCByID(casketID, instance)

            if casket and casket:getStatus() == xi.status.DISAPPEAR then
                local pos = mob:getPos()
                casket:setPos(pos.x, pos.y, pos.z, pos.rot)
                casket:resetLocalVars()
                casket:setStatus(xi.status.NORMAL)

                if params and params.itemID_1 ~= nil then
                    casket:setLocalVar('itemID_1', params.itemID_1)
                    casket:setLocalVar('itemAmount_1', params.itemAmount_1)
                end

                break
            end
        end
    end
end

xi.salvage.spawnUniqueTempChest = function(mob, chance, mobID)
    local ID       = zones[mob:getZoneID()]
    local instance = mob:getInstance()

    if math.random(100) <= chance then
        for _, casketID in ipairs(ID.npc[0].TEMP_ITEMS_BOX) do
            local casket = GetNPCByID(casketID, instance)

            if casket and casket:getStatus() == xi.status.DISAPPEAR then
                local pos = mob:getPos()
                casket:setPos(pos.x, pos.y, pos.z, pos.rot)
                casket:resetLocalVars()
                casket:setStatus(xi.status.NORMAL)
                casket:setLocalVar('uniqueTempChest', mobID)
                break
            end
        end
    end
end

xi.salvage.resetTempBoxes = function(player, instance)
    local ID = zones[player:getZoneID()]

    for _, casketID in ipairs(ID.npc[0].TEMP_ITEMS_BOX) do
        local casket = GetNPCByID(casketID, instance)

        if casket and casket:getStatus() ~= xi.status.DISAPPEAR then
            casket:setStatus(xi.status.DISAPPEAR)
            casket:resetLocalVars()
            casket:setAnimationSub(0)
        end
    end
end

xi.salvage.tempBoxTrigger = function(player, npc, customItemTable)
    if npc:getLocalVar('itemsPicked') == 0 then
        local dTableBoxItems = {}
        local sourceTable = customItemTable or tempBoxItems

        for i = 1, #sourceTable do
            local src = sourceTable[i]
            local resolvedAmount = src.amount

            if src.minAmount ~= nil then
                resolvedAmount = math.random(src.minAmount, src.maxAmount)
            end

            table.insert(dTableBoxItems, { itemID = src.itemID, amount = resolvedAmount })
        end

        local item2Random = math.random(100)
        local item3Random = math.random(100)

        local entry = math.random(1, #dTableBoxItems)
        local item  = dTableBoxItems[entry]

        npc:setLocalVar('itemID_1', item.itemID)
        npc:setLocalVar('itemAmount_1', item.amount)
        table.remove(dTableBoxItems, entry)

        -- 95% chance for a second item
        if item2Random <= 95 then
            entry = math.random(1, #dTableBoxItems)
            item  = dTableBoxItems[entry]
            npc:setLocalVar('itemID_2', item.itemID)
            npc:setLocalVar('itemAmount_2', item.amount)
            table.remove(dTableBoxItems, entry)
        end

        -- 25% chance for a third item (only if second item rolled)
        if item2Random <= 95 and item3Random <= 25 then
            entry = math.random(1, #dTableBoxItems)
            item  = dTableBoxItems[entry]
            npc:setLocalVar('itemID_3', item.itemID)
            npc:setLocalVar('itemAmount_3', item.amount)
            table.remove(dTableBoxItems, entry)
        end

        npc:entityAnimationPacket(xi.animationString.OPEN_CRATE_GLOW)
        npc:setAnimationSub(13)
        npc:setLocalVar('itemsPicked', 1)
    end

    player:startEvent(2,
    {
        [0] = (npc:getLocalVar('itemID_1') + (npc:getLocalVar('itemAmount_1') * 65536)),
        [1] = (npc:getLocalVar('itemID_2') + (npc:getLocalVar('itemAmount_2') * 65536)),
        [2] = (npc:getLocalVar('itemID_3') + (npc:getLocalVar('itemAmount_3') * 65536)),
    })
end

xi.salvage.tempBoxFinish = function(player, csid, option, npc)
    local ID = zones[player:getZoneID()]

    if csid == 2 then
        local item1 = npc:getLocalVar('itemID_1')
        local item2 = npc:getLocalVar('itemID_2')
        local item3 = npc:getLocalVar('itemID_3')

        if option == 1 and item1 > 0 and npc:getLocalVar('itemAmount_1') > 0 then
            if not player:hasItem(item1, xi.inventoryLocation.TEMPITEMS) then
                player:addTempItem(item1)
                player:messageSpecial(ID.text.TEMP_ITEM, item1)
                npc:setLocalVar('itemAmount_1', npc:getLocalVar('itemAmount_1') - 1)
            else
                player:messageSpecial(ID.text.HAVE_TEMP_ITEM)
            end

        elseif option == 2 and item2 > 0 and npc:getLocalVar('itemAmount_2') > 0 then
            if not player:hasItem(item2, xi.inventoryLocation.TEMPITEMS) then
                player:addTempItem(item2)
                player:messageSpecial(ID.text.TEMP_ITEM, item2)
                npc:setLocalVar('itemAmount_2', npc:getLocalVar('itemAmount_2') - 1)
            else
                player:messageSpecial(ID.text.HAVE_TEMP_ITEM)
            end

        elseif option == 3 and item3 > 0 and npc:getLocalVar('itemAmount_3') > 0 then
            if not player:hasItem(item3, xi.inventoryLocation.TEMPITEMS) then
                player:addTempItem(item3)
                player:messageSpecial(ID.text.TEMP_ITEM, item3)
                npc:setLocalVar('itemAmount_3', npc:getLocalVar('itemAmount_3') - 1)
            else
                player:messageSpecial(ID.text.HAVE_TEMP_ITEM)
            end
        end

        -- Close box if all slots empty
        if
            npc:getLocalVar('itemAmount_1') == 0 and
            npc:getLocalVar('itemAmount_2') == 0 and
            npc:getLocalVar('itemAmount_3') == 0
        then
            npc:queue(10000, function(npcArg)
                npcArg:entityAnimationPacket(xi.animationString.STATUS_DISAPPEAR)
                npcArg:resetLocalVars()
            end)

            npc:queue(12000, function(npcArg)
                npcArg:setStatus(xi.status.DISAPPEAR)
                npcArg:setAnimationSub(0)
            end)
        end
    end
end
