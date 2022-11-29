﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Almoxarifado.Domain.Entities;
using Almoxarifado.Domain.Interfaces;


namespace Almoxarifado.Domain.Interfaces.IRepository
{
    public interface ICategoriaMedicamentoRepository : IRepository<CategoriaMedicamento>
    {
       
        CategoriaMedicamento ObterPorNomeCategoriaMedicamento(string nomeCategoriaMedicamento);

    }
}
