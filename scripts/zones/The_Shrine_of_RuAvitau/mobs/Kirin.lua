-----------------------------------
-- Area: The Shrine of Ru'Avitau
--   NM: Kirin
-----------------------------------
local ID = zones[xi.zone.THE_SHRINE_OF_RUAVITAU]
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

-- God mob IDs (offset from Kirin)
local gods = { ID.mob.KIRIN + 1, ID.mob.KIRIN + 2, ID.mob.KIRIN + 3, ID.mob.KIRIN + 4 }

local callPetParams =
{
    dieWithOwner = true,
    superLink = true,
    inactiveTime = 9000, -- 9 second cast time
    maxSpawns = 1,
}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 5, 'Kirins_Avatar')
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:setMobMod(xi.mobMod.ASTRAL_PET_OFFSET, 5)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    mob:setMobMod(xi.mobMod.WEAPON_BONUS, 30)
    mob:setMod(xi.mod.DEFP, 30)
    mob:setMod(xi.mod.REGEN, 50)
    mob:setMod(xi.mod.REGAIN, 1000) -- Kirin never stops using TP moves unless casting
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar('godSpawnTime', GetSystemTime() + math.random(180, 300)) -- 3-5 minutes

    -- Wait 5 seconds after spawn to cast
    mob:setMagicCastingEnabled(false)
    mob:timer(5000, function(mobArg)
        if mobArg then
            mobArg:setMagicCastingEnabled(true)
        end
    end)
end

entity.onMobEngage = function(mob, target)
    mob:messageText(mob, ID.text.KIRIN_OFFSET)
end

entity.onMobFight = function(mob, target)
    -- Check if it's time to spawn a god
    local numAdds = mob:getLocalVar('numAdds')
    if GetSystemTime() >= mob:getLocalVar('godSpawnTime') and numAdds < 4 then
        -- Find which gods have never been spawned
        local availableGods = {}
        for i = 1, 4 do
            if mob:getLocalVar('add' .. i) == 0 then
                table.insert(availableGods, gods[i])
            end
        end

        -- Spawn one random god if any are available
        if #availableGods > 0 then
            local selectedGod = availableGods[math.random(1, #availableGods)]

            -- Use callPets to spawn exactly one god
            if xi.mob.callPets(mob, selectedGod, callPetParams) then
                -- Mark this god as spawned and update counter
                for i = 1, 4 do
                    if gods[i] == selectedGod then
                        mob:setLocalVar('add' .. i, 1)
                        break
                    end
                end

                mob:setLocalVar('numAdds', numAdds + 1)

                -- Set next god spawn time (3-5 minutes later)
                mob:setLocalVar('godSpawnTime', GetSystemTime() + math.random(180, 300))
            end
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.KIRIN_CAPTIVATOR)
    player:showText(mob, ID.text.KIRIN_OFFSET + 1)
end

return entity
