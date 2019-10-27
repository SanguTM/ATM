using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;

namespace ATM
{

    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        //Form2 form2 = new Form2();

        private void Form1_Load(object sender, EventArgs e)
        {

        }

        private void Button1_Click(object sender, EventArgs e)
        {
            //pagal http://csharp.net-informations.com/data-providers/csharp-sql-server-connection.htm
            {
                string ConnectionString = null;
                //SqlConnection con = new SqlConnection("Data Source=Sangu-PC;Initial Catalog=Testas;User ID=sa;Password=asas");
                SqlConnection con;
                ConnectionString = "Data Source = Sangu-PC; Initial Catalog = Testas; User ID = sa; Password = asas";
                //ConnectionString = "Data Source = LENOVO\\SQL2016; Initial Catalog = Testas; User ID = sa; Password = qwer7894;";
                con = new SqlConnection();
                con.ConnectionString = ConnectionString;
                //SqlCommand cmd = new SqlCommand("Select kodas, password from Users where kodas = 'username.text' and password =  'password.text'");
                string sql = null;
                SqlDataReader dataReader;
                SqlCommand cmd;
                DataTable TempTable = new DataTable(); //this is creating a virtual table  

                try
                {
                    con.Open();
                    SqlDataAdapter sda = new SqlDataAdapter();
                    cmd = new SqlCommand("usp_login");
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@piKodas", SqlDbType.NVarChar, 255));
                    cmd.Parameters.Add(new SqlParameter("@piPassword", SqlDbType.NVarChar, 255));
                    cmd.Parameters["@piKodas"].Value = textBox1.Text;
                    cmd.Parameters["@piPassword"].Value = textBox2.Text;
                    cmd.Connection = con;
                    cmd.ExecuteNonQuery();

                    //Iš https://www.c-sharpcorner.com/UploadFile/9582c9/login-form-with-sql-in-C-Sharp/
                    sda.SelectCommand = cmd;
                    sda.Fill(TempTable);
                    if (TempTable.Rows[0][0].ToString() == "1")
                    {
                        /* I have made a new page called home page. If the user is successfully authenticated then the form will be moved to the next form */
                        this.Hide();
                        //new Form2().Show();

                    }
                    else
                        MessageBox.Show("Invalid username or password");

                    con.Close();
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Can not open connection ! " + ex.Message);

                    // And to close
                    //form2.Close();
                    this.Close();
                }

            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection("Data Source = Sangu-PC; Initial Catalog = Testas; User ID = sa; Password = asas");
        }
         if (textBox1.Text != "" && textBox2.text != "" )
            {
            string UserName = textBox1.Text;
            string Password = Cryptography.Encrypt(textBox2.Text.ToString());
            const.Open();
    }
}
