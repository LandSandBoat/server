-----------------------------------
-- Area: The Garden of Ru'Hmet
--  Mob: Aw'aern
-- Note: PH for Ix'Aern DRK and DRG
-----------------------------------
mixins = { require('scripts/mixins/families/aern') }
local ID = zones[xi.zone.THE_GARDEN_OF_RUHMET]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Aerns_Euvhi')
    xi.pet.setMobPet(mob, 1, 'Aerns_Wynav')
    xi.pet.setMobPet(mob, 1, 'Aerns_Elemental')
end

entity.onMobSpawn = function(mob)
    local ixaernDrg = GetMobByID(ID.mob.IXAERN_DRG)
    if not ixaernDrg then
        return
    end

    if ixaernDrg:isSpawned() then
        return
    end

    local zone = mob:getZone()
    if not zone then
        return
    end

    if zone:getLocalVar('[SEA]IxAernDRG_PH') ~= 0 then
        return
    end

    -- Pick the Ix'Aern (DRG) PH if the server doesn't have one, and the if the actual PH/NM isn't up. Then, set it.
    -- Give Ix'DRG a random placeholder by picking one of the four groups' first PH, then adding a random number of 0-2 for the specific mob.
    local basePhId = utils.randomEntry(ID.mob.AWAERN_DRG_GROUPS)
    zone:setLocalVar('[SEA]IxAernDRG_PH', basePhId + math.randomInt(0, 2))
end

entity.onMobDeath = function(mob, player, optParams)
    -- Ix'Aern DRK animosity mechanic
    if not optParams.isKiller then
        return
    end

    local qmDrk = GetNPCByID(ID.npc.QM_IXAERN_DRK)
    if not qmDrk then
        return
    end

    if qmDrk:getStatus() == xi.status.DISAPPEAR then
        return
    end

    local hatedPlayer = qmDrk:getLocalVar('hatedPlayer')

    if hatedPlayer == 0 or qmDrk:getLocalVar('hateTimer') <= GetSystemTime() then
        -- If hated player took too long, reset
        if hatedPlayer ~= 0 then
            qmDrk:setLocalVar('hatedPlayer', 0)
            qmDrk:setLocalVar('hateTimer', 0)
        end

        -- if aern belongs to QM group, chance for sheer animosity
        local position = GetNPCByID(ID.npc.QM_IXAERN_DRK):getLocalVar('position')
        local offset   = mob:getID() - ID.mob.AWAERN_DRK_GROUPS[position]
        if offset < 0 and offset > 2 then
            return
        end

        if math.randomInt(1, 8) > 1 then
            return
        end

        qmDrk:setLocalVar('hatedPlayer', player:getID())
        qmDrk:setLocalVar('hateTimer', GetSystemTime() + 600) -- player with animosity has 10 minutes to touch QM
        player:messageSpecial(ID.text.SHEER_ANIMOSITY)
    end
end

entity.onMobDespawn = function(mob)
    local zone = mob:getZone()
    if not zone then
        return
    end

    local mobId       = mob:getID()
    local IxAernDRGPH = zone:getLocalVar('[SEA]IxAernDRG_PH') -- Should be be the ID of the mob that spawns the actual PH.

    -- If the mob killed was the randomized PH, then Ix'Aern (DRG) in the specific spot, unclaimed and not aggroed.
    if IxAernDRGPH ~= mobId then
        return
    end

    -- Select spawn location based on ID
    local offset = mobId - ID.mob.AWAERN_DRG_GROUPS[1]
    if offset >= 0 and offset <= 3 then
        GetMobByID(ID.mob.IXAERN_DRG):setSpawn(-520, 5, -520, 225) -- Bottom Left
    elseif offset >= 4 and offset <= 7 then
        GetMobByID(ID.mob.IXAERN_DRG):setSpawn(-520, 5, -359, 30) -- Top Left
    elseif offset >= 8 and offset <= 11 then
        GetMobByID(ID.mob.IXAERN_DRG):setSpawn(-319, 5, -359, 95) -- Top Right
    else
        GetMobByID(ID.mob.IXAERN_DRG):setSpawn(-319, 5, -520, 156) -- Bottom Right
    end

    SpawnMob(ID.mob.IXAERN_DRG)
    zone:setLocalVar('[SEA]IxAernDRG_PH', 0) -- Clear the variable because it is spawned!
end

return entity
