-----------------------------------
-- func: addalltrusts
-- desc: Adds all trust spells to the given target. If no target then to the current player.
--       utilizes !addallspells to not duplicate complex logic
-----------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 's'
}

local function error(player, msg)
    player:printToPlayer(msg)
    player:printToPlayer('!addalltrusts (player)')
end

commandObj.onTrigger = function(player, target)
    local validSpells =
    {
        896, 897, 898, 899, 900, 901, 902, 903, 904, 905, 906, 907, 908, 909, 910, 911, 912, 913, 914, 915, 916, 917, 918, 919, 920,
        921, 922, 923, 924, 925, 926, 927, 928, 929, 930, 931, 932, 933, 934, 935, 936, 937, 938, 939, 940, 941, 942, 943, 944, 945,
        946, 947, 948, 949, 950, 951, 952, 953, 954, 955, 956, 957, 958, 959, 960, 961, 962, 963, 964, 965, 966, 967, 968, 969, 970,
        971, 972, 973, 974, 975, 976, 977, 978, 979, 980, 981, 982, 983, 984, 985, 986, 987, 988, 989, 990, 991, 992, 993, 994, 995,
        996, 997, 998, 999,
        1003, 1004, 1005, 1006, 1007, 1008, 1009, 1010, 1011, 1012, 1013, 1014, 1015, 1016, 1017, 1018, 1019
    }

    -- validate target
    local targ
    if target == nil then
        targ = player
    else
        targ = GetPlayerByName(target)
        if targ == nil then
            error(player, fmt('Player named "{}" not found!', target))
            return
        end
    end

    if
        xi.commands.addallspells and
        type(xi.commands.addallspells.onTrigger) == 'function'
    then
        player:printToPlayer(fmt('Queuing unlock of all trust spells for {}', targ:getName()), xi.msg.channel.SYSTEM_3)
        xi.commands.addallspells.onTrigger(player, target, validSpells)
    else
        player:printToPlayer(fmt('An error occurred calling !addallspells to learn all trusts'))
    end
end

return commandObj
