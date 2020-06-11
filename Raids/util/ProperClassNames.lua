-- BEGIN_IMPORT
-- import Raids.globals.Facades end
-- END_IMPORT

function displayProperClassName(improperClassName)
    if OLD_CLASS_NAME_FACADE[improperClassName] ~= nil then return OLD_CLASS_NAME_FACADE[improperClassName] end
    return improperClassName
end

function parseProperClassName(properClassName)
    if NEW_CLASS_NAME_FACADE[properClassName] ~= nil then return NEW_CLASS_NAME_FACADE[properClassName] end
    return properClassName
end