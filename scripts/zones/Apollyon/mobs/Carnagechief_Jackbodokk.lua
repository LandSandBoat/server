-----------------------------------
-- Area: Apollyon CS
--  Mob: Carnagechief Jackbodokk
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
    SpawnMob(16933130):setMobMod(tpz.mobMod.SUPERLINK, mob:getShortID())
    SpawnMob(16933131):setMobMod(tpz.mobMod.SUPERLINK, mob:getShortID())
    SpawnMob(16933132):setMobMod(tpz.mobMod.SUPERLINK, mob:getShortID())
end

function onMobFight(mob, target)
    local mobID = mob:getID()
    local X = mob:getXPos()
    local Y = mob:getYPos()
    local Z = mob:getZPos()
    local lifepourcent= ((mob:getHP()/mob:getMaxHP())*100)
    local instancetime = target:getBattlefieldTimeLeft(Central_Temenos_2nd_Floor)


    if (lifepourcent < 50 and GetNPCByID(16933245):getAnimation() == 8) then
        SpawnMob(16933134):setMobMod(tpz.mobMod.SUPERLINK, mob:getShortID())
        SpawnMob(16933135):setMobMod(tpz.mobMod.SUPERLINK, mob:getShortID())
        SpawnMob(16933133):setMobMod(tpz.mobMod.SUPERLINK, mob:getShortID())
        SpawnMob(16933136):setMobMod(tpz.mobMod.SUPERLINK, mob:getShortID())
        GetNPCByID(16933245):setAnimation(9)
    end

    if (instancetime < 13) then
        if (GetMobByID(16933144):isAlive()) then
            GetMobByID(16933144):updateEnmity(target)
        elseif (GetMobByID(16933137):isAlive()) then
            GetMobByID(16933137):updateEnmity(target)
        end
    end
end

function onMobDeath(mob, player, isKiller)
    if ( ( GetMobByID(16933144):isAlive() or GetMobByID(16933137):isAlive() ) and alreadyReceived(player, 1, Central_Temenos_2nd_Floor) == false) then
        player:addTimeToBattlefield(Central_Temenos_2nd_Floor, 5)
        addLimbusList(player, 1, Central_Temenos_2nd_Floor)
    end
end
