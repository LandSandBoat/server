-----------------------------------
-- Area: Wajaom Woodlands
--  Mob: Percipient Zoraal Ja
-----------------------------------
local ID = zones[xi.zone.WAJAOM_WOODLANDS]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
end

entity.onMobSpawn = function(mob)
    xi.pet.setMobPet(mob, -1, 'Zoraal_Jas_Pkuucha')
end

entity.onMobEngage = function(mob, target)
    mob:messageText(mob, ID.text.FORGIVE_I_WILL_NOT)
end

entity.onMobFight = function(mob, target)
    local pet = mob:getPet()

    if not pet then
        return
    end

    if pet:getHPP() <= 33 then
        mob:setLocalVar('usedReward', 0) -- Reset the Reward usage flag when pet is below 33% HPP
    end

    if
        pet:getHPP() <= 33 and
        mob:getLocalVar('usedReward') == 0
    then
        mob:setLocalVar('usedReward', 1)
        mob:useMobAbility(xi.mobSkill.REWARD)
    end
end

-- On death, makes Zoraal Ja's Pkuucha killable again
entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        local pet = GetMobByID(ID.mob.ZORAAL_JAS_PKUUCHA)
        if pet ~= nil then
            pet:setUnkillable(false)
            if pet:getHPP() <= 1 then
                pet:setHP(0)
            end
        end
    end
end

return entity
