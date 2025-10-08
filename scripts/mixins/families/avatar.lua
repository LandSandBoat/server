-- Note: override random model selection and delay until astral flow via mobmods
--  xi.mobMod.AVATAR_PETID: avatar pet from xi.petId to select model/ability from
--  xi.mobMod.AVATAR_ASTRAL_DELAY: number of milliseconds to delay AF after avatar spawn (defaults to immediately... i.e. value of zero)

require('scripts/globals/mixins')

-- keyed on avatar modelId
local abilityData =
{
    [ 791] = { petId = xi.petId.CARBUNCLE, abilityId =  919 },
    [ 792] = { petId = xi.petId.FENRIR,    abilityId =  839 },
    [ 793] = { petId = xi.petId.IFRIT,     abilityId =  913 },
    [ 794] = { petId = xi.petId.TITAN,     abilityId =  914 },
    [ 795] = { petId = xi.petId.LEVIATHAN, abilityId =  915 },
    [ 796] = { petId = xi.petId.GARUDA,    abilityId =  916 },
    [ 797] = { petId = xi.petId.SHIVA,     abilityId =  917 },
    [ 798] = { petId = xi.petId.RAMUH,     abilityId =  918 },
    [1145] = { petId = xi.petId.DIABOLOS,  abilityId = 1911 },
}

local randomAvatarOptions =
{
    xi.petId.CARBUNCLE,
    xi.petId.FENRIR,
    xi.petId.IFRIT,
    xi.petId.TITAN,
    xi.petId.LEVIATHAN,
    xi.petId.GARUDA,
    xi.petId.SHIVA,
    xi.petId.RAMUH,
}

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.avatar = function(avatarMob)
    avatarMob:addListener('SPAWN', 'AVATAR_SPAWN', function(mob)
        mob:removeListener('AVATAR_MOBSKILL_FINISHED')

        local modelId = 0
        local petId   = mob:getMobMod(xi.mobMod.AVATAR_PETID)
        if petId == 0 then
            -- choose a random petId since it's not specified by the avatar mob
            petId = utils.randomEntry(randomAvatarOptions)
        end

        for mId, ability in pairs(abilityData) do
            if ability.petId == petId then
                modelId = mId
                break
            end
        end

        if modelId == 0 then
            -- if AVATAR_PETID is set and doesn't map to an ability, exit and don't install listeners
            -- this is used for pets that can either use AF or be regular pets (like Pandemonium Lamps)
            return
        end

        mob:setModelId(modelId)
        mob:hideName(false)
        mob:setUntargetable(true)
        mob:setUnkillable(true)
        mob:setAutoAttackEnabled(false)
        mob:setMobAbilityEnabled(false)
        mob:setMagicCastingEnabled(false)

        -- most AF avatars are not actually assigned as a mob pet, avatar is set to engage owner's target in astral_flow.lua
        local master = mob:getMaster()
        if master ~= nil then
            local target = master:getTarget()
            if target ~= nil then
                mob:updateEnmity(target)
            end
        end

        -- avatar dies as soon as AF ability completes
        mob:addListener('WEAPONSKILL_STATE_EXIT', 'AVATAR_MOBSKILL_FINISHED', function(mobArg)
            mobArg:setUnkillable(false)
            mobArg:setHP(0)
        end)

        -- If something goes wrong, the avatar will clean itself up 5s after astralDelayMs
        local astralDelayMs = mob:getMobMod(xi.mobMod.AVATAR_ASTRAL_DELAY) > 0 and mob:getMobMod(xi.mobMod.AVATAR_ASTRAL_DELAY) or 0
        mob:timer(astralDelayMs + 5000, function(mobArg)
            if mobArg:isAlive() then
                mobArg:setUnkillable(false)
                mobArg:setHP(0)
            end
        end)
    end)

    avatarMob:addListener('ENGAGE', 'AVATAR_ENGAGE', function(mob, target)
        local modelId       = mob:getModelId()
        local abilityId     = abilityData[modelId] and abilityData[modelId].abilityId or 0 -- Use AF ability AVATAR_ASTRAL_DELAY milliseconds after spawn/engage (engaged immediately in astral_flow.lua)
        local astralDelayMs = mob:getMobMod(xi.mobMod.AVATAR_ASTRAL_DELAY) > 0 and mob:getMobMod(xi.mobMod.AVATAR_ASTRAL_DELAY) or 0

        if abilityId > 0 then
            mob:timer(astralDelayMs, function(mobArg)
                if mobArg:isAlive() then
                    mobArg:useMobAbility(abilityId)
                end
            end)
        end
    end)
end

return g_mixins.families.avatar
