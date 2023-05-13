---@class Method : java.lang.reflect.Method
Method = {}

---@param arg0 Class|Unknown
---@return void
function Method:checkCanSetAccessible(arg0) end

---@public
---@return String
function Method:toString() end

---@return String
function Method:toShortSignature() end

---@public
---@return boolean
function Method:isBridge() end

---@return MethodRepository
function Method:getGenericInfo() end

---@return Class[]
function Method:getSharedExceptionTypes() end

---@public
---@return String
function Method:getName() end

---@public
---@param arg0 Class|Unknown
---@return Annotation
function Method:getAnnotation(arg0) end

---@return String
function Method:toShortString() end

---@public
---@return Type[]
function Method:getGenericParameterTypes() end

---@param arg0 int
---@param arg1 Class[]
---@return boolean
function Method:handleParameterNumberMismatch(arg0, arg1) end

---@return Method
function Method:leafCopy() end

---@public
---@return Annotation[][]
function Method:getParameterAnnotations() end

---@public
---@return int
function Method:hashCode() end

---@public
---@return Class|Unknown
function Method:getReturnType() end

---@private
---@return String
function Method:getGenericSignature() end

---@private
---@return GenericsFactory
function Method:getFactory() end

---@public
---@param arg0 Object
---@return boolean
function Method:equals(arg0) end

---@public
---@return TypeVariable[]
function Method:getTypeParameters() end

---@return MethodAccessor
function Method:getMethodAccessor() end

---@public
---@return AnnotatedType
function Method:getAnnotatedReturnType() end

---@return byte[]
function Method:getAnnotationBytes() end

---@public
---@return boolean
function Method:isSynthetic() end

---@public
---@return Type[]
function Method:getGenericExceptionTypes() end

---@public
---@return int
function Method:getParameterCount() end

---@public
---@param arg0 Object
---@param arg1 Object[]
---@return Object
function Method:invoke(arg0, arg1) end

---@param arg0 StringBuilder
---@return void
function Method:specificToGenericStringHeader(arg0) end

---@public
---@return boolean
function Method:isDefault() end

---@public
---@return String
function Method:toGenericString() end

---@public
---@return Annotation[]
function Method:getDeclaredAnnotations() end

---@public
---@param arg0 boolean
---@return void
function Method:setAccessible(arg0) end

---@private
---@return MethodAccessor
function Method:acquireMethodAccessor() end

---@param arg0 StringBuilder
---@return void
function Method:specificToStringHeader(arg0) end

---@return Method
function Method:getRoot() end

---@public
---@return Class[]
function Method:getExceptionTypes() end

---@public
---@return Object
function Method:getDefaultValue() end

---@public
---@return int
function Method:getModifiers() end

---@param arg0 MethodAccessor
---@return void
function Method:setMethodAccessor(arg0) end

---@public
---@return Type
function Method:getGenericReturnType() end

---@public
---@return boolean
function Method:isVarArgs() end

---@return Method
function Method:copy() end

---@public
---@return Class[]
function Method:getParameterTypes() end

---@return boolean
function Method:hasGenericInformation() end

---@return Class[]
function Method:getSharedParameterTypes() end

---@public
---@return Class|Unknown
function Method:getDeclaringClass() end
