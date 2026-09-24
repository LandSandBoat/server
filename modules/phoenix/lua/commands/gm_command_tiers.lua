-----------------------------------
-- Phoenix GM tiers and targeting.
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('phoenix_gm_command_tiers')

local commandTiers =
{
    [0] =
    {
        'TH',
        'debuginfo',
        'th',
        'uptime',
    },
    [1] =
    {
        'animation',
        'build',
        'cansee',
        'changejob',
        'changesjob',
        'chocobo',
        'costume',
        'costume2',
        'down',
        'dynavars',
        'geteffects',
        'getenmity',
        'getfamily',
        'getid',
        'getmobaction',
        'getmobflags',
        'getmobmod',
        'getmod',
        'getpool',
        'getprevzoneline',
        'getspecies',
        'getstats',
        'getta',
        'gettp',
        'gmhome',
        'goto',
        'gotoid',
        'gotoname',
        'hide',
        'inwater',
        'menu',
        'menu_paginated',
        'monstrosity',
        'mount',
        'pos',
        'return',
        'speed',
        'time',
        'togglegm',
        'up',
        'wallhack',
        'where',
        'zone',
    },
    [2] =
    {
        'afkcheck',
        'bring',
        'checkinstance',
        'checkinteraction',
        'checklocalvar',
        'checkmission',
        'checkmissionstatus',
        'checkquest',
        'checkvar',
        'getcraftrank',
        'getfame',
        'getfishers',
        'getlocalvars',
        'getquestvar',
        'getskill',
        'getwspoints',
        'hasitem',
        'haskeyitem',
        'hastitle',
        'homepoint',
        'jail',
        'logoff',
        'posfix',
        'raise',
        'release',
        'send',
    },
    [3] =
    {
        'addabytime',
        'adddynatime',
        'addeffect',
        'addlights',
        'addtempitem',
        'ah',
        'animatenpc',
        'animatesubnpc',
        'cs',
        'cs2',
        'deleffect',
        'delkeyitem',
        'delmission',
        'delquest',
        'despawnmob',
        'dynadespawn',
        'dynaplayer',
        'dynareset',
        'dynaspawn',
        'dynastart',
        'entityvisual',
        'garrison',
        'godmode',
        'hp',
        'immortal',
        'instance',
        'messagebasic',
        'messagespecial',
        'messagestandard',
        'minigame',
        'mobhere',
        'mobskill',
        'mobsub',
        'mp',
        'npchere',
        'pardon',
        'petgodmode',
        'pettp',
        'posemannequin',
        'provokeall',
        'rdyna',
        'reset',
        'resetlights',
        'setbattlefieldtime',
        'setlocalvar',
        'setmobflags',
        'setmoblevel',
        'setmobmod',
        'setmod',
        'setmusic',
        'setplayermodel',
        'setweather',
        'sleep',
        'spawnmob',
        'stun',
        'tp',
        'trustengage',
        'yell',
    },
    [4] =
    {
        'addallatma',
        'addallattachments',
        'addallmaps',
        'addallmonstrosity',
        'addallmounts',
        'addallspells',
        'addalltrusts',
        'addallwarps',
        'addallweaponskills',
        'addcurrency',
        'addfish',
        'additem',
        'addkeyitem',
        'addmission',
        'addquest',
        'addspell',
        'addtitle',
        'addtreasure',
        'addweaponskillpoints',
        'breaklinkshell',
        'capallskills',
        'capskill',
        'cnation',
        'completemission',
        'completequest',
        'completerecord',
        'cp',
        'delallweaponskills',
        'delcurrency',
        'delitem',
        'delspell',
        'givebonanzapearl',
        'givegil',
        'giveitem',
        'givels',
        'givemagianitem',
        'givexp',
        'masterjob',
        'mission',
        'quest',
        'racechange',
        'rename',
        'setallegiance',
        'setbag',
        'setcapacitypoints',
        'setcraftrank',
        'setfamelevel',
        'setgil',
        'setjobpoints',
        'setmentor',
        'setmerits',
        'setmissionstatus',
        'setplayerlevel',
        'setplayernation',
        'setplayervar',
        'setprogress',
        'setquestvar',
        'setrank',
        'setskill',
        'setstage',
        'takegil',
        'takexp',
    },
    [5] =
    {
        'addtime',
        'chocoboraising',
        'crash',
        'delallinventory',
        'delcontaineritems',
        'exec',
        'fafnir',
        'gc_full',
        'gc_step',
        'inject',
        'injectaction',
        'naga',
        'promote',
        'rebuildnavmesh',
        'reloadbattlefield',
        'reloaddefaultactions',
        'reloadglobal',
        'reloadinteraction',
        'reloadmagians',
        'reloadnavmesh',
        'reloadquest',
        'reloadrecipes',
        'treants',
        'updateconquest',
    },
}

m:addOverride('xi.server.onServerStart', function()
    super()

    for tier, commands in pairs(commandTiers) do
        for _, name in ipairs(commands) do
            xi.commands[name].cmdprops.permission = tier
        end
    end

    xi.commands.costume.cmdprops.parameters = 'is'
end)

m:addOverride('xi.commands.costume.onTrigger', function(player, costumeId, target)
    if not costumeId or costumeId < 0 then
        player:printToPlayer('Invalid costumeID.', xi.msg.channel.SYSTEM_3)
        player:printToPlayer('!costume <costumeID> (player)', xi.msg.channel.SYSTEM_3)
        return
    end

    if not target then
        return super(player, costumeId)
    end

    local targetPlayer = GetPlayerByName(target)
    if not targetPlayer then
        player:printToPlayer(string.format('Player named "%s" not found!', target), xi.msg.channel.SYSTEM_3)
        return
    end

    if targetPlayer:getID() ~= player:getID() and player:getGMLevel() < 3 then
        player:printToPlayer('Tier 3 is required to costume another player.', xi.msg.channel.SYSTEM_3)
        return
    end

    targetPlayer:setCostume(costumeId)
end)

-- Keep tier checks active after command reloads.
for tier, commands in pairs(commandTiers) do
    if tier > 0 then
        for _, name in ipairs(commands) do
            m:addOverride('xi.commands.' .. name .. '.onTrigger', function(player, ...)
                if player:getGMLevel() < tier then
                    player:printToPlayer(string.format('Tier %i is required to use !%s.', tier, name), xi.msg.channel.SYSTEM_3)
                    return
                end

                return super(player, ...)
            end)
        end
    end
end
