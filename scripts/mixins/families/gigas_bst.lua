-----------------------------------
-- Mixin for regular Gigas Beastmaster mobs (not the NMs).
-- They summon their bat pet with the Summoner cast, and while unengaged resummon it on a timer. A pet
-- killed in combat is not resummoned until the mob is no longer engaged, because ROAM_TICK (which drives
-- the summon) never fires while engaged. See scripts/mixins/families/gigas_bst_nm.lua for the NM variant.
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

g_mixins.families.gigas_beastmaster = function(mob)
    mob:addListener('SPAWN', 'GIGAS_BST_SPAWN', function(mobArg)
        mobArg:setMobMod(xi.mobMod.SPECIAL_SKILL, 0)
        mobArg:setLocalVar('[Pet]Timer', 0)
    end)

    mob:addListener('ROAM_TICK', 'GIGAS_BST_ROAM_TICK', function(mobArg)
        -- Never interrupt an in-progress summon (callPets stuns the owner during the cast).
        if xi.combat.behavior.isEntityBusy(mobArg) then
            return
        end

        local petId = mobArg:getID() + 1 -- Gigas BST mobs link their bat at mob id + 1 (see setMobPet).
        local pet   = GetMobByID(petId)
        if not pet then
            return
        end

        if pet:isSpawned() then
            return
        end

        local currentTime = GetSystemTime()
        local summonTime  = mobArg:getLocalVar('[Pet]Timer')
        if summonTime == 0 then
            mobArg:setLocalVar('[Pet]Timer', currentTime + math.randomInt(60, 70))
            return
        end

        if currentTime < summonTime then
            return
        end

        if xi.mob.callPets(mobArg, petId, callPetParams) then
            mobArg:setLocalVar('[Pet]Timer', 0)
        end
    end)
end

return g_mixins.families.gigas_beastmaster
