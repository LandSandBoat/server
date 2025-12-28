-----------------------------------
-- Salvage Global Functions
-----------------------------------
xi = xi or {}
xi.salvage = xi.salvage or {}
-----------------------------------

xi.salvage.onCellItemCheck = function(target, effect, value)
    if target:getCurrentRegion() ~= xi.region.ALZADAAL then
        return xi.msg.basic.CANT_BE_USED_IN_AREA
    end

    local statusEffect = target:getStatusEffect(effect)
    if statusEffect then
        local power = statusEffect:getPower()
        if bit.band(power, value) > 0 then
            return 0
        end
    end

    return xi.msg.basic.ITEM_UNABLE_TO_USE
end

xi.salvage.onCellItemUse = function(target, effect, value, offset)
    local statusEffect = target:getStatusEffect(effect)
    local power        = statusEffect:getPower()
    local newpower     = bit.band(power, bit.bnot(value))
    local pet          = target:getPet()
    local instance     = target:getInstance()

    target:delStatusEffectSilent(effect)
    if newpower > 0 then
        local duration = math.floor(statusEffect:getTimeRemaining() / 1000)
        target:addStatusEffectEx(effect, effect, newpower, 0, duration)
    end

    if
        pet ~= nil and
        (
            effect == xi.effect.DEBILITATION or
            effect == xi.effect.IMPAIRMENT or
            effect == xi.effect.OMERTA
        )
    then
        pet:delStatusEffectSilent(effect)
        if newpower > 0 then
            local duration = math.floor(statusEffect:getTimeRemaining() / 1000)
            pet:addStatusEffectEx(effect, effect, newpower, 0, duration)
        end
    end

    target:messageText(target, zones[target:getZoneID()].text.CELL_OFFSET + offset)
    instance:setLocalVar('cellsUsed', instance:getLocalVar('cellsUsed') + 1)
end

xi.salvage.instanceRegister = function(player, fireFlies)
    for i = xi.slot.MAIN, xi.slot.BACK do
        player:unequipItem(i)
    end

    player:addStatusEffectEx(xi.effect.ENCUMBRANCE_I, xi.effect.ENCUMBRANCE_I, 65535, 0, 6000)
    player:addStatusEffectEx(xi.effect.OBLIVISCENCE, xi.effect.OBLIVISCENCE, 1, 0, 6000)
    player:addStatusEffectEx(xi.effect.OMERTA, xi.effect.OMERTA, 63, 0, 6000)
    player:addStatusEffectEx(xi.effect.IMPAIRMENT, xi.effect.IMPAIRMENT, 3, 0, 6000)
    player:addStatusEffectEx(xi.effect.DEBILITATION, xi.effect.DEBILITATION, 511, 0, 6000)
    player:addTempItem(fireFlies)
    player:delKeyItem(xi.ki.REMNANTS_PERMIT)
end

xi.salvage.onFailure = function(instance)
    local chars = instance:getChars()
    local mobs  = instance:getMobs()

    for _, mob in pairs(mobs) do
        DespawnMob(mob:getID(), instance)
    end

    if #chars > 0 then
        for _, player in ipairs(chars) do
            local ID  = zones[player:getZoneID()]
            player:messageSpecial(ID.text.MISSION_FAILED, 10, 10)
            player:startCutscene(1)
        end
    end
end

xi.salvage.onTransportUpdate = function(player, instance)
    if instance:getLocalVar('transportUser') == 0 then
        local chars = instance:getChars()

        instance:setLocalVar('transportUser', player:getID())
        instance:setLocalVar('stageComplete', 0)
        xi.salvage.resetTempBoxes(player)
        xi.salvage.deSpawnStage(instance)
        for _, target in pairs(chars) do
            if target:getID() ~= player:getID() then
                if target:isInEvent() then
                    target:release()
                end
            end
        end

        player:timer(10000, function(playerArg)
            instance:setLocalVar('transportUser', 0)
        end)
    else
        return
    end
end

xi.salvage.teleportGroup = function(target)
    local instance = target:getInstance()
    local chars    = instance:getChars()
    local pos      = target:getPos()
    local csid     = target:getZoneID() == xi.zone.BHAFLAU_REMNANTS and 4 or 3

    for _, players in pairs(chars) do
        if players:getID() ~= target:getID() then
            players:startCutscene(csid)
            players:timer(4000, function(targetArg)
                targetArg:setPos(pos.x, pos.y, pos.z, pos.rot)
                targetArg:setHP(targetArg:getMaxHP())
                targetArg:setMP(targetArg:getMaxMP())

                local pet = targetArg:getPet()
                if pet then
                    pet:setPos(pos.x, pos.y, pos.z, pos.rot)
                    pet:setHP(pet:getMaxHP())
                    pet:setMP(pet:getMaxMP())
                end
            end)
        end
    end
end

xi.salvage.onDoorOpen = function(npc, stage, progress)
    local instance = npc:getInstance()
    local result   = false

    if
        npc:getAnimation() == xi.animation.CLOSE_DOOR and
        npc:getLocalVar('unSealed') == 1
    then
        npc:setLocalVar('unSealed', 0)
        if stage ~= nil then
            instance:setStage(stage)
        end

        if progress ~= nil then
            instance:setProgress(progress)
        end

        npc:setAnimation(xi.animation.OPEN_DOOR)
        npc:setUntargetable(true)
        result = true
    end

    return result
end

xi.salvage.sealDoors = function(instance, indexID)
    if type(indexID) == 'table' then
        for _, id in pairs(indexID) do
            local door = GetNPCByID(id, instance)
            if door then
                door:setLocalVar('unSealed', 0)
            end
        end
    else
        local door = GetNPCByID(indexID, instance)
        if door then
            door:setLocalVar('unSealed', 0)
        end
    end
end

xi.salvage.unsealDoors = function(instance, indexID)
    if type(indexID) == 'table' then
        for _, id in pairs(indexID) do
            local door = GetNPCByID(id, instance)
            if door then
                door:setLocalVar('unSealed', 1)
            end
        end
    else
        local door = GetNPCByID(indexID, instance)
        if door then
            door:setLocalVar('unSealed', 1)
        end
    end
end

xi.salvage.openBossDoor = function(npc)
    if npc:getAnimation() == xi.anim.CLOSE_DOOR then
        local instance = npc:getInstance()

        npc:openDoor(15)
        npc:queue(3000, function(npcArg)
            GetNPCByID(npcArg:getID() -1, instance):openDoor(10)
        end)
    end
end

xi.salvage.onTriggerCrate = function(player, npc)
    if npc:getLocalVar('open') == 0 then
        npc:setLocalVar('open', 1)
        local firstRandom =
        {
            xi.item.CUMULUS_CELL,
            xi.item.UNDULATUS_CELL,
            xi.item.HUMILUS_CELL,
            xi.item.SPISSATUS_CELL
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
            xi.item.MEDIOCRIS_CELL
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

        npc:entityAnimationPacket('open')
        npc:timer(15000, function(npcArg)
            npcArg:entityAnimationPacket('kesu')
        end)

        npc:timer(16000, function(npcArg)
            npcArg:setStatus(xi.status.DISAPPEAR)
        end)
    end
end

xi.salvage.handleSlot = function(player, npc, trade, card, mobID)
    if npcUtil.tradeHasExactly(trade, card) then
        local instance = npc:getInstance()
        SpawnMob(mobID, instance):updateClaim(player)
        player:confirmTrade()
        npc:setStatus(xi.status.DISAPPEAR)
    end
end

xi.salvage.handleSocket = function(player, npc, trade, mobID)
    local instance  = npc:getInstance()
    local mob       = GetMobByID(mobID, instance)
    local cellCount = trade:getItemCount()

    for cellType = xi.item.INCUS_CELL, xi.item.SPISSATUS_CELL do
        if cellCount <= 5 and trade:hasItemQty(cellType, cellCount) then
            player:tradeComplete()
            if mob then
                SpawnMob(mobID, instance):updateClaim(player)
                mob:setLocalVar('tradedCell', cellType)
                mob:setLocalVar('cellCount', cellCount)
                npc:setStatus(xi.status.DISAPPEAR)
            end
        end
    end
end

xi.salvage.handleSocketCells = function(mob, player)
    local amount = mob:getLocalVar('cellCount') * 2

    while amount > 0 do
        player:addTreasure(mob:getLocalVar('tradedCell'), mob)
        amount = amount - 1
    end
end

xi.salvage.spawnGroup = function(instance, indexID)
    if indexID then
        for _, enemies in pairs(indexID) do
            if type(enemies) == 'table' then
                for _, groups in pairs(enemies) do
                    if type(groups) == 'table' then
                        for _, subGroups in pairs(groups) do
                            SpawnMob(subGroups, instance)
                            GetMobByID(subGroups, instance):setLocalVar('spawned', 1)
                        end
                    else
                        SpawnMob(groups, instance)
                        GetMobByID(groups, instance):setLocalVar('spawned', 1)
                    end
                end
            else
                SpawnMob(enemies, instance)
                GetMobByID(enemies, instance):setLocalVar('spawned', 1)
            end
        end
    end
end

xi.salvage.groupKilled = function(instance, indexID)
    for _, enemies in pairs(indexID) do
        if type(enemies) == 'table' then
            for _, groups in pairs(enemies) do
                if type(groups) == 'table' then
                    for _, subGroups in pairs(groups) do
                        local mob = GetMobByID(subGroups, instance)
                        if mob and mob:getLocalVar('spawned') == 0 then
                            return false
                        elseif mob and mob:isAlive() then
                            return false
                        end
                    end
                else
                    local mob = GetMobByID(groups, instance)
                    if mob and mob:getLocalVar('spawned') == 0 then
                        return false
                    elseif mob and mob:isAlive() then
                        return false
                    end
                end
            end
        else
            local mob = GetMobByID(enemies, instance)

            if mob and mob:getLocalVar('spawned') == 0 then
                return false
            elseif mob and mob:isAlive() then
                return false
            end
        end
    end

    return true
end

xi.salvage.deSpawnStage = function(instance)
    local mobs = instance:getMobs()

    for _, enemy in pairs(mobs) do
        DespawnMob(enemy:getID(), instance)
    end
end

xi.salvage.resetTempBoxes = function(player)
    local ID          = zones[player:getZoneID()]
    local instance    = player:getInstance()
    local tempBoxes   = utils.slice(ID.npc.ARMOURY_CRATE, 2, #ID.npc.ARMOURY_CRATE)
    local staticBoxes = ID.npc.STATIC_TEMP_BOX

    if tempBoxes then
        for _, casketID in ipairs(tempBoxes) do
            local casket = GetNPCByID(casketID, instance)
            if casket and casket:getStatus() == xi.status.NORMAL then
                casket:setStatus(xi.status.DISAPPEAR)
                casket:resetLocalVars()
                casket:setAnimationSub(8)
            end
        end
    end

    if staticBoxes then
        for _, casketID in ipairs(staticBoxes) do
            local casket = GetNPCByID(casketID, instance)
            if casket and casket:getStatus() == xi.status.NORMAL then
                casket:setStatus(xi.status.DISAPPEAR)
                casket:resetLocalVars()
                casket:setAnimationSub(8)
            end
        end
    end
end

xi.salvage.spawnTempChest = function(mob, params)
    local ID       = zones[mob:getZoneID()]
    local instance = mob:getInstance()

    -- default params
    if not params then
        params = {}
    end

    if params.rate == nil then
        if mob:getZoneID() == xi.zone.ARRAPAGO_REMNANTS then
            params.rate = 300
        else
            params.rate = 40
        end
    end

    if params.rate ~= 0 then
        if params.rate < math.random(1, 1000) then
            return
        end
    end

    if params.itemID_1 == nil or type(params.itemID_1) ~= 'number' then
        params.itemID_1 = false
    end

    for _, casketID in ipairs(utils.slice(ID.npc.ARMOURY_CRATE, 2, #ID.npc.ARMOURY_CRATE)) do
        local casket = GetNPCByID(casketID, instance)
        if casket and casket:getStatus() == xi.status.DISAPPEAR then
            local pos = mob:getPos()
            casket:setPos(pos.x, pos.y, pos.z, pos.rot)
            casket:resetLocalVars()
            casket:setStatus(xi.status.NORMAL)

            if params.itemID_1 then
                casket:setLocalVar('prePicked', 1)
                casket:setLocalVar('itemID_1', params.itemID_1)
                casket:setLocalVar('itemAmount_1', params.itemAmount_1)
            end

            if params.specialAmount then
                casket:setLocalVar(params.special, params.specialAmount)
            end

            break
        end
    end
end

xi.salvage.tempBoxTrigger = function(player, npc)
    if npc:getLocalVar('itemsPicked') == 0 then
        npc:setLocalVar('itemsPicked', 1)
        npc:entityAnimationPacket('open')
        npc:setAnimationSub(13)
        if npc:getLocalVar('prePicked') == 0 then
            xi.salvage.tempBoxPickItems(npc)
        end
    end

    player:startEvent(2,
    {
        [0] = (npc:getLocalVar('itemID_1') + (npc:getLocalVar('itemAmount_1') * 65536)),
        [1] = (npc:getLocalVar('itemID_2') + (npc:getLocalVar('itemAmount_2') * 65536)),
        [2] = (npc:getLocalVar('itemID_3') + (npc:getLocalVar('itemAmount_3') * 65536)),
        [3] = (npc:getLocalVar('itemID_4') + (npc:getLocalVar('itemAmount_4') * 65536)),
        [4] = (npc:getLocalVar('itemID_5') + (npc:getLocalVar('itemAmount_5') * 65536)),
        [5] = (npc:getLocalVar('itemID_6') + (npc:getLocalVar('itemAmount_6') * 65536)),
        [6] = (npc:getLocalVar('itemID_7') + (npc:getLocalVar('itemAmount_7') * 65536))
    })
end

xi.salvage.tempBoxPickItems = function(npc)
    local tempBoxItems =
    {
        [1]  = { itemID = xi.item.BOTTLE_OF_BARBARIANS_DRINK, amount = math.random(1, 3) },
        [2]  = { itemID = xi.item.BOTTLE_OF_FIGHTERS_DRINK,   amount = math.random(1, 3) },
        [3]  = { itemID = xi.item.BOTTLE_OF_ORACLES_DRINK,    amount = math.random(1, 3) },
        [4]  = { itemID = xi.item.BOTTLE_OF_ASSASSINS_DRINK,  amount = math.random(1, 3) },
        [5]  = { itemID = xi.item.BOTTLE_OF_SPYS_DRINK,       amount = math.random(1, 3) },
        [6]  = { itemID = xi.item.BOTTLE_OF_BRAVERS_DRINK,    amount = math.random(1, 3) },
        [7]  = { itemID = xi.item.BOTTLE_OF_SOLDIERS_DRINK,   amount = math.random(1, 3) },
        [8]  = { itemID = xi.item.BOTTLE_OF_CHAMPIONS_DRINK,  amount = math.random(1, 3) },
        [9]  = { itemID = xi.item.BOTTLE_OF_MONARCHS_DRINK,   amount = math.random(1, 3) },
        [10] = { itemID = xi.item.BOTTLE_OF_GNOSTICS_DRINK,   amount = math.random(1, 3) },
        [11] = { itemID = xi.item.BOTTLE_OF_CLERICS_DRINK,    amount = math.random(1, 3) },
        [12] = { itemID = xi.item.BOTTLE_OF_SHEPHERDS_DRINK,  amount = math.random(1, 3) },
        [13] = { itemID = xi.item.BOTTLE_OF_SPRINTERS_DRINK,  amount = math.random(1, 3) },
        [14] = { itemID = xi.item.FLASK_OF_STRANGE_MILK,      amount = math.random(1, 5) },
        [15] = { itemID = xi.item.BOTTLE_OF_STRANGE_JUICE,    amount = math.random(1, 5) },
        [16] = { itemID = xi.item.BOTTLE_OF_FANATICS_DRINK,   amount = 1 },
        [17] = { itemID = xi.item.BOTTLE_OF_FOOLS_DRINK,      amount = 1 },
        [18] = { itemID = xi.item.DUSTY_WING,                 amount = 1 },
        [19] = { itemID = xi.item.BOTTLE_OF_VICARS_DRINK,     amount = math.random(1, 3) },
        [20] = { itemID = xi.item.DUSTY_POTION,               amount = math.random(1, 10) },
        [21] = { itemID = xi.item.DUSTY_ETHER,                amount = math.random(1, 10) },
        [22] = { itemID = xi.item.DUSTY_ELIXIR,               amount = 1 }
    }
    local chosen1      = math.random(1, #tempBoxItems)
    local item1        = tempBoxItems[chosen1]
    local item2random = math.random(1, 10) > 4
    local item3random = math.random(1, 10) > 8

    if npc:getLocalVar('itemID_1') == 0 then
        npc:setLocalVar('itemID_1', item1.itemID)
        npc:setLocalVar('itemAmount_1', item1.amount)
        table.remove(tempBoxItems, chosen1)
    end

    if item2random then
        local chosen2 = math.random(1, #tempBoxItems)
        local item2   = tempBoxItems[chosen2]

        npc:setLocalVar('itemID_2', item2.itemID)
        npc:setLocalVar('itemAmount_2', item2.amount)
        table.remove(tempBoxItems, chosen2)
    end

    if item3random then
        local chosen3 = math.random(1, #tempBoxItems)
        local item3   = tempBoxItems[chosen3]

        npc:setLocalVar('itemID_3', item3.itemID)
        npc:setLocalVar('itemAmount_3', item3.amount)
        table.remove(tempBoxItems, chosen3)
    end
end

xi.salvage.tempBoxFinish = function(player, csid, option, npc)
    local ID = zones[player:getZoneID()]

    if csid == 2 then
        for choice = 1, 8 do
            if option == choice then
                local item = npc:getLocalVar('itemID_'..choice)
                local itemQnty = npc:getLocalVar('itemAmount_'..choice)

                if item > 0 and itemQnty > 0 then
                    if not player:hasItem(item, xi.inventoryLocation.TEMPITEMS) then
                        player:addTempItem(item)
                        player:messageSpecial(ID.text.TEMP_ITEM, item)
                        npc:setLocalVar('itemAmount_'..choice, itemQnty - 1)
                    else
                        player:messageSpecial(ID.text.HAVE_TEMP_ITEM)
                    end
                end
            end
        end

        -- despawn box if no items left
        if
            npc:getLocalVar('itemAmount_1') == 0 and
            npc:getLocalVar('itemAmount_2') == 0 and
            npc:getLocalVar('itemAmount_3') == 0 and
            npc:getLocalVar('itemAmount_4') == 0 and
            npc:getLocalVar('itemAmount_5') == 0 and
            npc:getLocalVar('itemAmount_6') == 0 and
            npc:getLocalVar('itemAmount_7') == 0
        then
            npc:queue(10000, function(npcArg)
                npcArg:entityAnimationPacket('kesu')
            end)

            npc:queue(12000, function(npcArg)
                npcArg:setStatus(xi.status.DISAPPEAR)
                npc:setAnimationSub(8)
            end)
        end
    end
end
