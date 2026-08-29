-----------------------------------
-- Vitesse de deplacement accrue dans les villes
--
-- Exemple de modification maison faite entierement via le systeme de modules
-- de LSB : aucun fichier du coeur n'est touche, donc aucun conflit lors des
-- merges depuis upstream.
--
-- Le bonus suit le joueur peu importe le processus xi_map qui sert la zone.
-----------------------------------
require('modules/module_utils')
require('scripts/globals/interaction/interaction_global')
-----------------------------------
local m = Module:new('city_move_speed')

-- Bonus additif applique avant les multiplicateurs.
-- La vitesse de base d'un joueur est 40 : +12 ~= +30 %.
local CITY_SPEED_BONUS = 12

local function isCity(zone)
    return zone ~= nil and bit.band(zone:getTypeMask(), xi.zoneType.CITY) ~= 0
end

-- On memorise le montant reellement applique dans une variable locale du
-- joueur : on peut ainsi le retirer proprement sans ecraser les autres
-- sources de MOVE_SPEED_STACKABLE (penalites d'equipement, etc.).
local function refreshCitySpeed(player)
    local applied = player:getLocalVar('JSL_CITY_SPEED')
    local wanted  = isCity(player:getZone()) and CITY_SPEED_BONUS or 0

    if applied == wanted then
        return
    end

    if applied ~= 0 then
        player:delMod(xi.mod.MOVE_SPEED_STACKABLE, applied)
    end

    if wanted ~= 0 then
        player:addMod(xi.mod.MOVE_SPEED_STACKABLE, wanted)
    end

    player:setLocalVar('JSL_CITY_SPEED', wanted)
end

m:addOverride('InteractionGlobal.onZoneIn', function(player, prevZone, fallbackFn)
    refreshCitySpeed(player)

    return super(player, prevZone, fallbackFn)
end)
