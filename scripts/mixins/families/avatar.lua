require("scripts/globals/mixins")

-- If you subtract 790 from the modelId, you're left with a key into to this table :)
local avatarInfo =
{
    { model = 791, ability = 919 }, -- Carbuncle
    { model = 793, ability = 913 }, -- Ifrit
    { model = 794, ability = 914 }, -- Titan
    { model = 795, ability = 915 }, -- Leviathan
    { model = 796, ability = 916 }, -- Garuda
    { model = 797, ability = 917 }, -- Shiva
    { model = 798, ability = 918 }, -- Ramuh
}

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.avatar = function(avatarMob)
    local avatarTable = avatarInfo[math.random(1, #avatarInfo)]
    avatarMob:addListener("SPAWN", "AVATAR_SPAWN", function(mob)
        mob:setModelId(avatarTable.model)
        mob:hideName(false)
        mob:setUntargetable(true)
        mob:setUnkillable(true)
        mob:setAutoAttackEnabled(false)
        mob:setMagicCastingEnabled(false)

        -- If something goes wrong, the avatar will clean itself up in 5s
        mob:timer(5000, function(mobArg)
            if mobArg:isAlive() then
                mobArg:setUnkillable(false)
                mobArg:setHP(0)
            end
        end)
    end)

    avatarMob:addListener("ENGAGE", "AVATAR_ENGAGE", function(mob, target)
        if mob:getLocalVar("[ASTRAL_FLOW]Performed") == 0 then
            local abilityId = avatarTable.ability
            if abilityId ~= nil then
                mob:useMobAbility(abilityId)
                mob:setLocalVar("[ASTRAL_FLOW]Performed", 1)
            end
        end
    end)

    avatarMob:addListener("WEAPONSKILL_STATE_EXIT", "AVATAR_MOBSKILL_FINISHED", function(mob)
        mob:setUnkillable(false)
        mob:setHP(0)
    end)
end

return g_mixins.families.avatar
