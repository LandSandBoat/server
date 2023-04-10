-----------------------------------
-- Area: La Vaule [S]
--   NM: Galarhigg (17125681 or 17125682 or 17125683)
--     : Fight for WOTG07 - Purple, The New Black
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
end

entity.onMobWeaponSkill = function(target, mob, skill)
    local id = skill:getID()

    if id == 624 or id == 625 or id == 626 then
        mob:delMod(xi.mod.FIRE_ABSORB, 100)
        mob:delMod(xi.mod.WATER_ABSORB, 100)
        mob:delMod(xi.mod.WIND_ABSORB, 100)
    end

    if id == 624 then -- follow with Flame Breah, fire absorb
        mob:setMod(xi.mod.FIRE_ABSORB, 100)
        mob:useMobAbility(642)
    elseif id == 625 then -- follow with Water Breath, water absorb
        mob:setMod(xi.mod.WATER_ABSORB, 100)
        mob:useMobAbility(643)
    elseif id == 626 then -- follow with Wind Breath, wind absorb
        mob:setMod(xi.mod.WIND_ABSORB, 100)
        mob:useMobAbility(644)

    elseif id == 627 then -- follow with random dragon skills, no known absorb
            local choose = math.random(1, 7)

            if choose == 1 then
                mob:useMobAbility(645) -- Body Slam
            elseif choose == 2 then
                mob:useMobAbility(646) -- Heavy Stomp
            elseif choose == 3 then
                mob:useMobAbility(647) -- Chaos Blade
            elseif choose == 4 then
                mob:useMobAbility(648) -- Petro Eyes
            elseif choose == 5 then
                mob:useMobAbility(649) -- Voindsong
            elseif choose == 6 then
                mob:useMobAbility(650) -- Thornsong
            elseif choose == 7 then
                mob:useMobAbility(651) -- Lodesong
            end
    end
end

return entity
