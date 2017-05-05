
namespace System.Reflection 
{



    public class TypeInfo // : System.Type
    {
        System.Type m_type;

        public TypeInfo(System.Type t)
        {
            this.m_type = t;
        }



        public bool IsGenericType
        {
            get
            {
                return this.m_type.IsGenericType;
            }
        }

        public bool IsValueType
        {
            get
            {
                return this.m_type.IsValueType;
            }
        }

        public bool IsPrimitive
        {
            get
            {
                return this.m_type.IsPrimitive;
            }
        }

        public System.Reflection.FieldInfo[] GetFields()
        {
            return this.m_type.GetFields();
        }

        public System.Reflection.PropertyInfo[] GetProperties()
        {
            return this.m_type.GetProperties();
        }

    }



    public static class IntrospectionExtensions
    {


        public static TypeInfo GetTypeInfo(System.Type type)
        {
            TypeInfo tt = new TypeInfo(type);

            return tt;
        }


    }


}