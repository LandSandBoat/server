-----------------------------------
-- Area: Apollyon CS
--  Mob: Dee Wapa the Desolator
-----------------------------------
require("scripts/globals/limbus")
-----------------------------------

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.SUPERLINK, mob:getShortID())
end

function onMobEngaged(mob, target)
    local mobID = mob:getID()
    local X = mob:getXPos()
    local Y = mob:getYPos()
    local Z = mob:getZPos()
    SpawnMob(16933148):setMobMod(tpz.mobMod.SUPERLINK, mob:getShortID())
    SpawnMob(16933147):setMobMod(tpz.mobMod.SUPERLINK, mob:getShortID())
    SpawnMob(16933149):setMobMod(tpz.mobMod.SUPERLINK, mob:getShortID())
    SpawnMob(16933146):setMobMod(tpz.mobMod.SUPERLINK, mob:getShortID())
end

function onMobFight(mob, target)
    local mobID = mob:getID()
    local X = mob:getXPos()
    local Y = mob:getYPos()
    local Z = mob:getZPos()
    local lifepourcent= ((mob:getHP()/mob:getMaxHP())*100)
    local instancetime = target:getBattlefieldTimeLeft(Central_Temenos_2nd_Floor)

    if (lifepourcent < 50 and GetNPCByID(16933247):getAnimation() == 8) then
        SpawnMob(16933151):setMobMod(tpz.mobMod.SUPERLINK, mob:getShortID())
        SpawnMob(16933150):setMobMod(tpz.mobMod.SUPERLINK, mob:getShortID())
        SpawnMob(16933152):setMobMod(tpz.mobMod.SUPERLINK, mob:getShortID())
        GetNPCByID(16933247):setAnimation(9)
    end

    if (instancetime < 13) then
        if (GetMobByID(16933129):isAlive()) then
            GetMobByID(16933129):updateEnmity(target)
        elseif (GetMobByID(16933137):isAlive()) then
            GetMobByID(16933137):updateEnmity(target)
        end
    end

end

function onMobDeath(mob, player, isKiller)
    if ( ( GetMobByID(16933129):isAlive() or GetMobByID(16933137):isAlive() ) and alreadyReceived(player, 3, Central_Temenos_2nd_Floor) == false) then
        player:addTimeToBattlefield(Central_Temenos_2nd_Floor, 5)
        addLimbusList(player, 3, Central_Temenos_2nd_Floor)
    end
end
