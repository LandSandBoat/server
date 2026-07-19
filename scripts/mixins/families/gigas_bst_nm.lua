-----------------------------------
-- Mixin for Gigas Beastmaster Notorious Monsters
-- They summon their bat pet with the Summoner cast and empower it with Familiar.
-- Currently used by: Enkelados, Eurymedon, Ophion, Pallas - Should also be added to Gigas Beastmaster when Expeditionary Force is implemented.
-----------------------------------
require('scripts/globals/mixins')
-----------------------------------
g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}
-----------------------------------

local callPetParams =
{
    inactiveTime   = 3000, -- Makes xi.mob.callPets play the retail Summoner cast (casm -> shsm) while summoning.
    persistOnDeath = true, -- The bat outlives the gigas.
    maxSpawns      = 1,
}

g_mixins.families.gigas_beastmaster_nm = function(mob)
    mob:addListener('SPAWN', 'GIGAS_BEASTMASTER_SPAWN', function(mobArg)
        mobArg:setMobMod(xi.mobMod.SPECIAL_SKILL, 0)

        mobArg:setLocalVar('[Pet]Timer', 0)
        mobArg:setLocalVar('[2-Hour]HPP', math.randomInt(40, 60))
        mobArg:setLocalVar('[2-Hour]Used', 0)
    end)

    mob:addListener('COMBAT_TICK', 'GIGAS_BST_NM_COMBAT_TICK', function(mobArg)
        -- Never interrupt an in-progress summon (callPets stuns the owner during the cast).
        if xi.combat.behavior.isEntityBusy(mobArg) then
            return
        end

        -- Fetch pet.
        local petId = mobArg:getID() + 1 -- Every gigas BST NM links its pet at mob id + 1 (see setMobPet).
        local pet   = GetMobByID(petId)
        if not pet then
            return
        end

        -- Get control variables.
        local currentTime    = GetSystemTime()
        local canUseFamiliar = mobArg:getLocalVar('[2-Hour]Used') == 0 and mobArg:getHPP() <= mobArg:getLocalVar('[2-Hour]HPP')

        -- Pet logic.
        if not pet:isAlive() then
            local petTime = mobArg:getLocalVar('[Pet]Timer')
            if petTime == 0 then
                mobArg:setLocalVar('[Pet]Timer', currentTime + 60)
                return
            end

            -- Summon whenever timer allows or bypass timer if it can 2-Hour.
            if currentTime < petTime and not canUseFamiliar then
                return
            end

            if not xi.mob.callPets(mobArg, petId, callPetParams) then
                return
            end

            mobArg:setLocalVar('[Pet]Timer', 0)
        end

        -- Use 2-Hour
        if not canUseFamiliar then
            return
        end

        mobArg:useMobAbility(xi.mobSkill.FAMILIAR_1)
        mobArg:setLocalVar('[2-Hour]Used', 1)
    end)
end

return g_mixins.families.gigas_beastmaster_nm
