-----------------------------------
-- Area: Arrapago Remnants
--  Mob: Archaic Rampart
-----------------------------------
mixins = { require('scripts/mixins/families/rampart') }
local ID = zones[xi.zone.ARRAPAGO_REMNANTS]
-----------------------------------
---@type TMobEntity
local entity = {}

-- Maps rampart mob IDs to their associated "pet" IDs.
local petMap =
{
    -- Floor 1
    [ID.mob[1][2].rampart]  = { ID.mob[1][2].sabotender },
    -- Floor 4 - N
    [ID.mob[4][2].rampart1] = { ID.mob[4][2].malboro },
    [ID.mob[4][2].rampart2] = { ID.mob[4][2].malboro },
    -- Floor 4 - S
    [ID.mob[4][1].rampart1] = { ID.mob[4][1].pugil1 },
    [ID.mob[4][1].rampart2] = { ID.mob[4][1].pugil2 },
    -- Floor 5 - S
    [ID.mob[5][1].rampart1] = { ID.mob[5][1].manta1, ID.mob[5][1].manta2 },
    [ID.mob[5][1].rampart2] = { ID.mob[5][1].orobon },
    [ID.mob[5][1].rampart3] = { ID.mob[5][1].orobon },
    -- Floor 5 - N
    [ID.mob[5][2].rampart1] = { ID.mob[5][2].mourioche1, ID.mob[5][2].mourioche2, ID.mob[5][2].mourioche3 },
    [ID.mob[5][2].rampart2] = { ID.mob[5][2].goobbue1 },
    [ID.mob[5][2].rampart3] = { ID.mob[5][2].goobbue2 },
    -- Floor 6
    [ID.mob[6].rampart1]    = { ID.mob[6].treant1 },
    [ID.mob[6].rampart2]    = { ID.mob[6].treant2 },
    [ID.mob[6].rampart3]    = { ID.mob[6].korrigan },
    [ID.mob[6].rampart4]    = { ID.mob[6].sapling },
}

entity.onMobSpawn = function(mob)
end

entity.onMobFight = function(mob, target)
    local instance = mob:getInstance()

    if not instance then
        return
    end

    local petIds = petMap[mob:getID()]

    if not petIds then
        return
    end

    local popTime = mob:getLocalVar('lastPetPop')
    local mobPos  = mob:getPos()

    local pets = {}
    for i, petId in ipairs(petIds) do
        pets[i] = GetMobByID(petId, instance)
    end

    if GetSystemTime() - popTime > 15 then
        for i, pet in ipairs(pets) do
            if pet and not pet:isSpawned() then
                pet:setSpawn(mobPos.x, mobPos.y, mobPos.z, mobPos.rot)
                mob:useMobAbility(xi.mobSkill.REINFORCEMENTS)
                mob:setLocalVar('lastPetPop', GetSystemTime())
                local spawnId = petIds[i]
                mob:timer(2500, function(m)
                    SpawnMob(spawnId, instance)
                end)

                break
            end
        end
    end

    for _, pet in ipairs(pets) do
        if pet and pet:isSpawned() then
            pet:updateEnmity(target)
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
    local instance = mob:getInstance()

    if not instance then
        return
    end

    if optParams.isKiller then
        if ID.mob[6].rampart1 == mob:getID() or ID.mob[6].rampart2 == mob:getID() then
            if instance:getStage() == 6 and instance:getProgress() >= 1 then
                instance:setProgress(instance:getProgress() + 1)
            end
        end

        xi.salvage.spawnTempChest(mob, {})
    end
end

entity.onMobDespawn = function(mob)
end

return entity
