-----------------------------------
-- Area: Apollyon CS
--  Mob: Na'Qba Chirurgeon
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
    SpawnMob(16933139):setMobMod(tpz.mobMod.SUPERLINK, mob:getShortID())
    SpawnMob(16933140):setMobMod(tpz.mobMod.SUPERLINK, mob:getShortID())
    SpawnMob(16933138):setMobMod(tpz.mobMod.SUPERLINK, mob:getShortID())
end

function onMobFight(mob, target)
    local mobID = mob:getID()
    local X = mob:getXPos()
    local Y = mob:getYPos()
    local Z = mob:getZPos()
    local lifepourcent= ((mob:getHP()/mob:getMaxHP())*100)
    local instancetime = target:getBattlefieldTimeLeft(Central_Temenos_2nd_Floor)

    if (lifepourcent < 50 and GetNPCByID(16933246):getAnimation() == 8) then
        SpawnMob(16933142):setMobMod(tpz.mobMod.SUPERLINK, mob:getShortID())
        SpawnMob(16933143):setMobMod(tpz.mobMod.SUPERLINK, mob:getShortID())
        SpawnMob(16933141):setMobMod(tpz.mobMod.SUPERLINK, mob:getShortID())
        GetNPCByID(16933246):setAnimation(9)
    end

    if (instancetime < 13) then
        if (GetMobByID(16933129):isAlive()) then
            GetMobByID(16933129):updateEnmity(target)
        elseif (GetMobByID(16933144):isAlive()) then
            GetMobByID(16933144):updateEnmity(target)
        end
    end
end

function onMobDeath(mob, player, isKiller)
    if ( ( GetMobByID(16933129):isAlive() or GetMobByID(16933144):isAlive() ) and alreadyReceived(player, 2, Central_Temenos_2nd_Floor) == false) then
        player:addTimeToBattlefield(Central_Temenos_2nd_Floor, 5)
        addLimbusList(player, 2, Central_Temenos_2nd_Floor)
    end
end
