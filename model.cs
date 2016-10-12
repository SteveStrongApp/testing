    public class  StudentMasters 

    { 

        [Key] 

        public int  StdID { get; set; } 

        [Required] 

        [Display(Name = "Name")]  

        public string  StdName { get; set; } 

        [Required] 

        [Display(Name = "Email")]  

        public string  Email { get; set; } 

        [Required] 

        [Display(Name = "Phone")]  

        public string  Phone { get; set; } 

  

        public string  Address { get; set; } 

    } 