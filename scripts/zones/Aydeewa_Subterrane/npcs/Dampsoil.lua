-----------------------------------
-- Area: Aydeewa Subterrane
-- NPC: Dampsoil
-- Note: Used to spawn Crystal Eater
-- !pos -302.285 36.716 -32.392
-----------------------------------
local ID = zones[xi.zone.AYDEEWA_SUBTERRANE]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    local item      = trade:getItemId()
    local isCrystal = item >= xi.item.FIRE_CRYSTAL and item <= xi.item.DARK_CRYSTAL
    local isCluster = item >= xi.item.FIRE_CLUSTER and item <= xi.item.DARK_CLUSTER

    -- Crystal Eater is already up: reject the trade
    local crystalEater = GetMobByID(ID.mob.CRYSTAL_EATER)
    if crystalEater and crystalEater:isSpawned() then
        player:messageSpecial(ID.text.NOTHING_HAPPENS_2)
        return
    end

    -- Trade must be exactly one crystal or one cluster
    if trade:getItemCount() ~= 1 or not (isCrystal or isCluster) then
        return
    end

    -- On 60-minute cooldown (from a failed trade OR a previous mob death)
    if GetSystemTime() <= npc:getLocalVar('tradeCooldown') then
        player:messageSpecial(ID.text.MUSHROOM_IS_GROWING_HERE)
        return
    end

    local trades    = npc:getLocalVar('trades')
    local threshold = npc:getLocalVar('threshold')

    -- Must have at least 3 trades to pop, but threshold is randomized between 3 and 10 to prevent predictability
    if threshold == 0 then
        threshold = math.randomInt(3, 10)
        npc:setLocalVar('threshold', threshold)
    end

    -- Clusters give a 50% chance to pop Crystal Eater, crystals give 20%
    local popChance = isCluster and 50 or 20

    if trades >= threshold and math.randomInt(1, 100) <= popChance then
        -- Crystal Eater pops. Cooldown is NOT applied here - it will be applied by the mob's onMobDeath handler when the fight ends
        player:messageSpecial(ID.text.MONSTER_MUSHROOM_SPROUTS)
        if crystalEater then
            SpawnMob(ID.mob.CRYSTAL_EATER):updateClaim(player)
        end

        npc:setLocalVar('trades', 0)
        npc:setLocalVar('threshold', 0)
    else
        -- No pop: bump up the trade counter
        player:messageSpecial(ID.text.MUSHROOM_HAS_GROWN)
        npc:setLocalVar('trades', trades + 1)

        local awardedItem = false

        -- 10% chance to award a mushroom item - if awarded, no cooldown applies
        if math.randomInt(1, 100) <= 10 then
            local tradeRewards =
            {
                xi.item.SLEEPSHROOM,
                xi.item.DANCESHROOM,
                xi.item.WOOZYSHROOM,
                xi.item.KING_TRUFFLE,
            }

            local rewardItem = tradeRewards[math.randomInt(1, 4)]
            if npcUtil.giveItem(player, rewardItem, { silent = true }) then
                player:messageSpecial(ID.text.PULL_UP_MUSHROOM_1, rewardItem)
                awardedItem = true
            end
        end

        -- Only apply the 60-minute cooldown when no item was awarded
        if not awardedItem then
            npc:setLocalVar('tradeCooldown', GetSystemTime() + 3600)
        end
    end

    player:tradeComplete()
end

entity.onTrigger = function(player, npc)
    -- Crystal Eater is alive right now
    local crystalEater = GetMobByID(ID.mob.CRYSTAL_EATER)
    if crystalEater and crystalEater:isSpawned() then
        player:messageSpecial(ID.text.TRACES_OF_MUSHROOMS)
        return
    end

    local cooldownActive = GetSystemTime() <= npc:getLocalVar('tradeCooldown')
    local trades         = npc:getLocalVar('trades')

    -- Cycle is fresh / fully reset: no pending trades and no active cooldown
    if trades == 0 and not cooldownActive then
        player:messageSpecial(ID.text.TRACES_OF_MUSHROOMS)
        return
    end

    -- Mid 60-minute cooldown (from a failed trade or recent mob death)
    if cooldownActive then
        player:messageSpecial(ID.text.MUSHROOM_IS_GROWING_HERE)
    else
        -- Trades have been made, cooldown elapsed, ready for more fertilizer
        player:messageSpecial(ID.text.MUSHROOM_NEEDS_FERTILIZER)
    end
end

return entity
