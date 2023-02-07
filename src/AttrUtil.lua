-- Attribute Utilities 
local Attr = {};


function Attr:SetAttributes (Object, List) 
    for k, v in List do
        Object:SetAttribute(k, v);
    end
end

    

return Attr;